class SystemsGamesController < ApplicationController
  def create
    options = params.require(:game).permit(:name)

    @game = system.games.create!(options)

    respond_to do |format|
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
