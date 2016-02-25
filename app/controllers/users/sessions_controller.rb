class Users::SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]
  prepend_before_filter { request.env["devise.mapping"] = Devise.mappings[:user] }
  before_action :set_return_to

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  def destroy
    DistSession.where(:session_id => cookies[:dist_session_id]).delete_all if cookies[:dist_session_id]
    cookies.delete :dist_session_id, :domain => Settings.shared_cookies_domain
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end

  def after_sign_in_path_for(resource_or_scope)
    dist_session = DistSession.find_or_create_by :session_id => session.id
    dist_session.update :data => {:user_id => resource.id}.to_json
    cookies[:dist_session_id] = {:value => dist_session.session_id, :domain => Settings.shared_cookies_domain}
    return_to = session[:return_to] ? session[:return_to] : Settings.hosts.web.url
  end

  def after_sign_out_path_for(resource_or_scope)
    @return_to ||= params[:return_to]
    return_to = @return_to ? @return_to : Settings.hosts.web.url
  end

  private

  def set_return_to
    session[:return_to] = params[:return_to] if params[:return_to]
    @return_to = params[:return_to] if params[:return_to]
  end
end
