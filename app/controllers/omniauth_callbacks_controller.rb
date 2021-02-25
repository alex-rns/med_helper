class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token

  def google_oauth2
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      auth = request.env["omniauth.auth"]
      @user.access_token = auth.credentials.token
      @user.expires_at = auth.credentials.expires_at
      @user.refresh_token = auth.credentials.refresh_token
      @user.save!
      cookies.delete :user_type
      sign_in(:user, @user)
      redirect_to home_path
    else
      session["devise.google_data"] = request.env["omniauth.auth"].uid
      auth = request.env["omniauth.auth"]
      @user.access_token = auth.credentials.token
      @user.expires_at = auth.credentials.expires_at
      @user.refresh_token = auth.credentials.refresh_token
      @user.email = auth.info.email
      @user.password = '12345123'
      @user.save!
      set_role(cookies[:user_type], @user)
      cookies.delete :user_type
      sign_in(:user, @user)
      redirect_to home_path
    end
  end

  private

  def set_role(cookies, user)
    if cookies == 'pacient'
      Client.create(user_id: user.id, email: user.email)
    else
      Expert.create(user_id: user.id, category_id: 1, email: user.email)
    end
  end
end
