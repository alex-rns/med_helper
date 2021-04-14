class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :success, :danger, :info, :warning, :primary, :secondary

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone, :address, :birthday])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :phone, :address, :birthday])
  end
end
