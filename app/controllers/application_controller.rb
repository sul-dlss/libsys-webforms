# nodoc: Autogenerated
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.to_s
    redirect_to root_url
  end

  # https://github.com/ryanb/cancan/issues/835#issuecomment-18663815
  before_action do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  def current_user
    @current_user ||= begin
      AuthorizedUser.find_by(user_id: user_id)
    end
  end
  helper_method :current_user

  def user_id
    request.env['REMOTE_USER'] || ENV['REMOTE_USER']
  end
  helper_method :user_id

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
end
