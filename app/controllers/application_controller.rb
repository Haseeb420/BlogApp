# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Postable
  include Pundit::Authorization
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,
                                        keys: %i[first_name last_name birthday email password
                                                 profile_img])
      devise_parameter_sanitizer.permit(:account_update,
                                        keys: %i[first_name last_name birthday email password
                                                 profile_img])
    end

  private
    def user_not_authorized
      flash.now[:alert] = 'You are not authorized to perform this action.'
      redirect_to(request.referer || root_path)
    end
  # def set_action_type
  #   case params[:action]
  # end
end
