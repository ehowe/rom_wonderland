class SystemsController < ApplicationController
  def index
    @systems = System.all

    respond_to do |format|
      format.json { render "systems/index", format: :rabl }
    end
  end

  def show
    @system = system

    respond_to do |format|
      format.json { render "systems/show", format: :rabl }
    end
  end

  def system
    System.find(params[:id])
  end
end
