class GamesController < ApplicationController
  def index
    @games = Game.all

    respond_to do |format|
      format.json { render "games/index", handlers: [:rabl] }
    end
  end

  def show
    @game = game

    respond_to do |format|
      format.json { render "games/show", handlers: [:rabl] }
    end
  end

  def destroy
    @game = game.destroy

    respond_to do |format|
      format.json { render "games/show", handlers: [:rabl] }
    end
  end

  def game
    @_game ||= Game.find(params[:id])
  end
end
