class Users::RegistrationsController < Devise::RegistrationsController
  after_action :create_vaccine_card, only: [:create]

  def create_vaccine_card
    Vaccine.create(user_id: @user.id)
  end

end
