class HomeController < ApplicationController
  def welcome
    @systems = System.all
  end
end
