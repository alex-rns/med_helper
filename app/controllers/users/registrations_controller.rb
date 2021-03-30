class Users::RegistrationsController < Devise::RegistrationsController
  # after_action :create_vaccine_card, only: [:create]

  def create
    cookies[:user_type] = params[:user][:type]
    redirect_to user_google_oauth2_omniauth_authorize_path
  end

  def edit
  end

  def update
    if params[:user][:type] == 'patient'
      current_user.patient!
      current_user.image.attach(io: File.open("app/assets/images/avatar.png"),
                                filename: "avatar.png")
      Card.create(user_id: current_user.id)
      create_vaccine_card
    else
      current_user.doctor!
      expert = Expert.create(user: current_user, category: Category.first)
      expert.image.attach(io: File.open("app/assets/images/doctor0.png"),
                                filename: "doctor0.png")
    end
    cookies.delete :user_type
    redirect_to home_path
  end


  def create_vaccine_card
    Vaccine.create(user_id: @user.id)
  end
end
