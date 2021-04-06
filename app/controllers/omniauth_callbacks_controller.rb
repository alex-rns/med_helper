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
      if @user.role?
        sign_in(:user, @user)
        redirect_to home_path
      elsif cookies[:user_type].present?
          if cookies[:user_type] == 'doctor'
            @user.doctor!
            expert = Expert.create!(user: @user, category: Category.first)
            expert.image.attach(io: File.open("app/assets/images/doctor0.png"),
                                    filename: "doctor0.png")
            sign_in(:user, @user)
            redirect_to home_path
          else
            @user.patient!
            card = Card.create(user_id: @user.id, birthday: Time.now.strftime('%d/%m/%Y'))
            card.image.attach(io: File.open("app/assets/images/avatar.png"),
                                    filename: "avatar.png")
            Vaccine.create(user_id: @user.id)
            sign_in(:user, @user)
            redirect_to home_path
          end
        else
          sign_in(:user, @user)
          redirect_to edit_user_registration_path
        end
      end
      cookies.delete :user_type
    end
end
