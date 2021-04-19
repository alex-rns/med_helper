require 'open-uri'
class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token

  def google_oauth2
    @user = User.from_omniauth(request.env["omniauth.auth"])
    auth = request.env["omniauth.auth"]
    @user.access_token = auth.credentials.token
    @user.expires_at = auth.credentials.expires_at
    @user.refresh_token = auth.credentials.refresh_token
    @user.save!
    set_role
    sign_in(:user, @user)
    if @user.role?
      redirect_to home_path
    else
      redirect_to edit_user_registration_path
    end
  end

  private

  def set_role
    @downloaded_image = open(@user.image)
    if cookies[:user_type] == 'doctor'
      @user.doctor!
      expert = Expert.create!(full_name: @user.name, category: Category.first, user: @user, level: Level.first)
      expert.image.attach(io: @downloaded_image,
                                  filename: "doctor0.png")
    elsif cookies[:user_type] == 'patient'
      @user.patient!
      card = Card.create(user_id: @user.id, birthday: Time.now.strftime('%d/%m/%Y'), full_name: @user.name)
      card.image.attach(io: @downloaded_image,
                                  filename: "avatar.png")
      Vaccine.create(user_id: @user.id)
    else
    end
    cookies.delete :user_type
  end
end
