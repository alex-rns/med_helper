class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :success, :danger, :info, :warning, :primary, :secondary

  protected

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
    unless get_patient?
      flash[:notice] = 'Страница не доступна'
      redirect_to home_path
    end
  end

  def correct_expert
    unless get_doctor?
      flash[:notice] = 'Страница не доступна'
      redirect_to home_path
    end
  end
end
