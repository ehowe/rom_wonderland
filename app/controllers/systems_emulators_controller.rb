class SystemsGamesController < ApplicationController
  def new
    @system = system

    respond_to do |format|
      format.html { render "emulators/new", handlers: [:haml] }
      format.json { render :nothing, status: 404 }
    end
  end

  def create
    process_emulator unless request.format.html?

    options = params.require(:emulator).permit(:name, :emulator)

    @game = system.emulators.create!(options)

    respond_to do |format|
      format.html { render "emulators/show", handlers: [:haml] }
      format.json { render "emulators/show", handlers: [:rabl] }
    end
  end

  def index
    @games = system.emulators.where(deleted_at: nil)

    respond_to do |format|
      format.json { render "emulators/index", handlers: [:rabl] }
    end
  end

  private

  def process_emulator
    if params.try(:[], :emulator).try(:[], :emulator)
      data = StringIO.new(Base64.decode64(params[:emulator][:emulator][:data]))
      data.class.class_eval { attr_accessor :original_filename, :content_type }
      data.original_filename = params[:emulator][:emulator][:filename]
      data.content_type = params[:emulator][:emulator][:content_type]
      params[:emulator][:emulator] = data
    end
  end

  def system
    System.find(params[:id])
  end
end
