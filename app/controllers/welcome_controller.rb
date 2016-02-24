class WelcomeController < ApplicationController
  before_action :authenticate_user!

  def index
    dist_session = DistSession.find_or_create_by :session_id => session.id
    dist_session
    cookies[:dist_session_id] = {:value => dist_session.session_id, :domain => '.localhost.com'} if Rails.env.development?


    if session[:target]
      redirect_to session[:target]
    else
      redirect_to 'http://www.localhost.com' if Rails.env.development?
    end
  end

  def authenticate_user!
    super
  end
end
