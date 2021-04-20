require 'open-uri'
class Users::RegistrationsController < Devise::RegistrationsController
  def create
    cookies[:user_type] = params[:user][:type]
    redirect_to user_google_oauth2_omniauth_authorize_path
  end

  def edit; end

  def update
    @downloaded_image = open(@user.image)
    if params[:user][:type] == 'doctor'
      @user.doctor!
      expert = Expert.create!(full_name: @user.name, category: Category.first, user: @user, level: Level.first)
      expert.image.attach(io: @downloaded_image, filename: 'doctor0.png')
    else
      @user.patient!
      card = Card.create(user_id: @user.id, birthday: Time.now.strftime('%d/%m/%Y'), full_name: @user.name)
      card.image.attach(io: @downloaded_image, filename: 'avatar.png')
      Vaccine.create(user_id: @user.id)
    end
    cookies.delete :user_type
    redirect_to home_path
  end

  private

  def create_vaccine_card
    Vaccine.create(user_id: @user.id)
  end
end
