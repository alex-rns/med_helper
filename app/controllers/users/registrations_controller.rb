class Users::RegistrationsController < Devise::RegistrationsController

  def create
    cookies[:user_type] = params[:user][:type]
    redirect_to user_google_oauth2_omniauth_authorize_path
  end

end
