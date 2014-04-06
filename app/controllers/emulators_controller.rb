class EmulatorsController < ApplicationController
  def index
    @emulators = Emulator.all

    respond_to do |format|
      format.json { render "emulators/index", handlers: [:rabl] }
    end
  end

  def show
    @emulator = emulator

    respond_to do |format|
      format.json { render "emulators/show", handlers: [:rabl] }
    end
  end

  def destroy
    @emulator = emulator.destroy

    respond_to do |format|
      format.json { render "emulators/show", handlers: [:rabl] }
    end
  end

  def emulator
    @_emulator ||= Emulator.find(params[:id])
  end
end
