class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token

  def google_oauth2
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      auth = request.env["omniauth.auth"]
      @user.access_token = auth.credentials.token
      @user.expires_at = auth.credentials.expires_at
      @user.refresh_token = auth.credentials.refresh_token
      @user.save!
      if cookies[:user_type].present?
        set_role(cookies[:user_type], @user)
        sign_in(:user, @user)
        redirect_to home_path
      else
        check_role(@user)
      end
      cookies.delete :user_type
    end
  end

  private

  def check_role(user)
    if user.client.present?||user.expert.present?
      sign_in(:user, user)
      redirect_to home_path
    else
      sign_in(:user, user)
      redirect_to edit_user_registration_path
    end
  end

  def set_role(cookies, user)
    if cookies == 'pacient'
      Client.create(user_id: user.id, email: user.email, dob: Time.now)
    elsif cookies == 'doctor'
      Expert.create(user_id: user.id, category_id: 1, email: user.email)
    else
    end
  end
end
