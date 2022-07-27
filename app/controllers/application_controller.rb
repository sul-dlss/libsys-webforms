# nodoc: Autogenerated
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.to_s
    redirect_to root_url
  end

  def current_user
    @current_user ||= begin
      AuthorizedUser.find_by(user_id: user_id)
    end
  end
  helper_method :current_user

  def user_id
    request.env['REMOTE_USER'].presence || ENV.fetch('REMOTE_USER', nil)
  end
  helper_method :user_id

  def display_name
    request.env['displayName'] || ENV.fetch('displayName') { current_user_name }
  end
  helper_method :display_name

  def client_ip
    request.env['HTTP_CLIENT_IP'] || ENV.fetch('HTTP_CLIENT_IP', nil)
  end
  helper_method :client_ip

  def webauth_user?
    current_user.present? && user_id.present?
  end
  helper_method :webauth_user?

  def current_user_name
    if current_user.nil?
      'Guest'
    else
      current_user.user_name
    end
  end

  def set_no_cache
    response.headers['Cache-Control'] = 'no-cache, no-store, max-age=0, must-revalidate'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = 'Fri, 01 Jan 1990 00:00:00 GMT'
  end
end
