class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :success, :danger, :info, :warning, :primary, :secondary

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name phone address birthday])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name phone address birthday])
  end

  def is_patient?
    redirect_to home_path, notice: 'Эта страница для Вас недоступна' if current_user.doctor?
  end

  def get_doctor?
    current_user.doctor?
  end

  def get_patient?
    current_user.patient?
  end

  def correct_user
    if get_patient?
    else
      flash[:notice] = 'Страница не доступна'
      redirect_to home_path
    end
  end

  def correct_expert
    if get_doctor?
    else
      flash[:notice] = 'Страница не доступна'
      redirect_to home_path
    end
  end
end
