class SystemsGamesController < ApplicationController
  def new
    @system = system

    respond_to do |format|
      format.html { render "games/new", handlers: [:haml] }
      format.json { render :nothing, status: 404 }
    end
  end

  def create
    process_rom unless request.format.html?

    options = params.require(:game).permit(:name, :rom)

    @game = system.games.create!(options)

    respond_to do |format|
      format.html { render "games/show", handlers: [:haml] }
      format.json { render "games/show", handlers: [:rabl] }
    end
  end

  def index
    @games = system.games.where(deleted_at: nil)

    respond_to do |format|
      format.json { render "games/index", handlers: [:rabl] }
    end
  end

  private

  def process_rom
    if params.try(:[], :game).try(:[], :rom)
      data = StringIO.new(Base64.decode64(params[:game][:rom][:data]))
      data.class.class_eval { attr_accessor :original_filename, :content_type }
      data.original_filename = params[:game][:rom][:filename]
      data.content_type = params[:game][:rom][:content_type]
      params[:game][:rom] = data
    end
  end

  def system
    System.find(params[:id])
  end
end
