class SystemsGamesController < ApplicationController
  def new
    @system = system

    respond_to do |format|
      format.html { render "games/new", format: :haml }
      format.json { render :nothing, status: 404 }
    end
  end

  def create
    options = params.require(:game).permit(:name, :rom)

    @game = system.games.create!(options)

    respond_to do |format|
      format.html { render "games/show", format: :haml }
      format.json { render "games/show", format: :rabl }
    end
  end

  def index
    @games = system.games

    respond_to do |format|
      format.json { render "games/index", format: :rabl }
    end
  end

  def system
    System.find(params[:id])
  end
end
