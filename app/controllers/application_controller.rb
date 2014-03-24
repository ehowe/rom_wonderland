class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :initialize_vars, unless: :format_html?

  def initialize_vars
    @all_systems = System.all
  end

  def format_html?
    ! request.format.html?
  end
end
