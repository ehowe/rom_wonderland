module RomWonderland
  class Client
    attr_reader :client, :response, :request
    attr_writer :request

    def initialize
      _self     = self

      @client = Rack::Client.new do
        use Rack::ContentLength
        use Rack::Config do |env|
          _self.request = Struct.new(:env, :content_type).new(env, env["CONTENT_TYPE"])
        end
        run Rails.application
      end
    end

    %w[get post put delete].each do |method|
      define_method(method) do |url, options={}|
        headers        = options.delete(:headers) || {}
      assert_success = options[:assert].nil? ? true : options.delete(:assert)
      params         = (options.delete(:params) || {}).merge(options) # unrecognized parameters go in the body

      format = params.delete(:format) || :json
      if format == :json
        headers.merge!(
          "ACCEPT" => "application/json",
        )
        unless params.empty?
          params = MultiJson.dump(params)
          headers.merge!(
            "CONTENT_TYPE"   => "application/json",
            "CONTENT_LENGTH" => params.size,
          )
        end
      end

      raise ArgumentError.new("url is required") unless url
      @response = Response.new(self, client.send(method, url, headers, params))
      raise RuntimeError.new(@response.inspect) if assert_success && !@response.successful?
      @response
      end
    end
  end

  class Response
    attr_reader :response, :request

    def method_missing(method, *args, &block)
      if response.respond_to?(method)
        response.send(method, *args, &block)
      else
        super
      end
    end

    def initialize(client, response)
      @client, @response = client, response
      @request = Rack::Request.new(client.request.env)
    end

    def json
      @json ||= Hashie::Mash.new(MultiJson.load(response.body))
    end

    def ready!(assert_success = true)
      response = @client.get(Rails.application.routes.url_helpers.request_url(json.request.id))

      exception = if assert_success && response.json.request.status != "completed"
                    job = Smithy::Request.find(response.json.request.id).actual
                    exception_id = job.rollbar_id
                    Rollbar.exceptions[exception_id]
                  end
      if exception
        raise exception
      elsif assert_success
        response.json.request.status.should == "completed"
      end
      response
    end

    def resource!(assert_success = true)
      ready!(assert_success)
      resource
    end

    def failed!
      response = ready!(false)
      response.json.request.status.should == "error"
      response
    end

    def resource
      request = json.request

      request.resource && @client.get(request.resource).json.values.first
    end

    def inspect
      <<-STRING
      #{@response.status} #{@request.request_method.upcase} #{@request.url}
      #{@response.headers.map{|k,v| "#{k}: #{v}"}.join("\n")}
      #{@response.body.inspect}
      STRING
    end
  end
end

module ClientHelper
  def create_client
    RomWonderland::Client.new
  end

  def json
    client.response.json
  end

  def parse_link_header(response)
    response.headers['Link'].split(", ").inject({}) do |r, link|
      value, key = link.match(/<(.*)>; rel="(\w+)"/).captures
      r.merge(key => value)
    end
  end
end


RSpec.configure do |config|
  config.include(ClientHelper)
end
