class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

    def user_not_authorized
      flash[:alert] = 'You are not authorized to perform this action'
      redirect_to root_path
    end

    def after_sign_in_path_for(resource)
      resource
    end

    def after_sign_out_path_for(resource)
      libraries_path
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:fname, :lname, :image, :balance, :library_id])
      devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :library_id])
      devise_parameter_sanitizer.permit(:account_update, keys: [:fname, :lname, :status, :image, :balance, :library_id])
    end
end
