require 'user_permissions'
class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do
    flash[:error] = 'Access denied!'
    redirect_to root_url
  end
  before_action :configure_permitted_parameters, if: :devise_controller?
  include UserPersmissions
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :birthday, :email, :password])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :birthday, :email, :password])
  end
end
