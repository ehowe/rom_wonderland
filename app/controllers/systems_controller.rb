class SystemsController < ApplicationController
  def index
    @systems = System.all

    respond_to do |format|
      format.json { render "systems/index", format: :rabl }
    end
  end

  def show
    @system = system
    @games  = system.games.paginate(page: params[:page])

    respond_to do |format|
      format.html { render "systems/show", format: :haml }
      format.json { render "systems/show", format: :rabl }
    end
  end

  # Javascript autocomplete
  def search
    @games = system.api_games.select { |g| g =~ /#{params[:term]}/i }.sort

    respond_to do |format|
      format.json { render json: @games }
    end
  end

  def system
    @_system ||= System.find(params[:id])
  end
end
