class Users::RegistrationsController < Devise::RegistrationsController
  # after_action :create_vaccine_card, only: [:create]

  def create
    cookies[:user_type] = params[:user][:type]
    redirect_to user_google_oauth2_omniauth_authorize_path
  end

  def create_vaccine_card
    Vaccine.create(user_id: @user.id)
  end
end
