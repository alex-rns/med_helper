class Users::RegistrationsController < Devise::RegistrationsController

  def create
    cookies[:user_type] = params[:user][:type]
    redirect_to user_google_oauth2_omniauth_authorize_path
  end
  
  def edit
  end

  def update
    if params[:user][:type] == 'pacient'
      Client.create(user_id: current_user.id, email: current_user.email, dob: Time.now)
    else
      Expert.create(user_id: current_user.id, category_id: 1, email: current_user.email)
    end
    cookies.delete :user_type
    redirect_to home_path
  end


  def create_vaccine_card
    Vaccine.create(user_id: @user.id)
  end
end
