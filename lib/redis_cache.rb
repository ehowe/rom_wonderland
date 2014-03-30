class Redis
  def cache(params={})
    key         = params[:key]         || raise(":key parameter is required!")
    expire      = params[:expire]
    recalculate = params[:recalculate]
    expire      = params[:expire]
    timeout     = params[:timeout]     || 0
    default     = params[:default]

    if (value = get(key)).nil? || recalculate

      begin
        value = Timeout::timeout(timeout) { yield(self) }
      rescue Timeout::Error
        value = default
      end

      set(key, value)
      expire(key, expire) if expire
      value
    else
      value
    end
  end
end
