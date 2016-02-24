class LogoutController < ApplicationController
  def index
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)

    DistSession.where(:session_id => cookies[:dist_session_id]).delete_all if cookies[:dist_session_id]
    cookies.delete :dist_session_id, :domain => '.localhost.com' if Rails.env.development?

    if params[:target]
      redirect_to params[:target]
    else
      redirect_to 'http://www.localhost.com' if Rails.env.development?
    end
  end
end
