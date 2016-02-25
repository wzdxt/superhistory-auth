class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  before_action :set_return_to

  def set_return_to
    session[:return_to] = params[:return_to] if params[:return_to]
    @return_to = params[:return_to] if params[:return_to]
  end
end
