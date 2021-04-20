class CardsController < ApplicationController
  before_action :set_card, only: %i[edit update]
  before_action :get_user, :get_card, only: %i[show], if: :get_doctor?
  before_action :get_patient_card, only: %i[show], if: :get_patient?
  before_action :correct_user, only: [:edit, :update]

  def show
    @protocols = protocols
  end

  def edit; end

  def update
    if @card.update(permit_params)
      redirect_to user_card_path(current_user, current_user.card), success: 'Ваша карта пациента изменена'
    else
      flash.now[:error] = 'Ваша карта пациента не изменена'
      render 'edit'
    end
  end

  private

  def get_user
    @user = User.find(params[:user_id])
  end

  def get_card
    @card = @user.card
  end

  def get_patient_card
    @card = current_user.card
  end

  def set_card
    @card = Card.find(params[:id])
  end

  def correct_user
    if get_patient?
    else
      redirect_to home_path
    end
  end

  def protocols
    current_user.doctor? ? @card.protocols.where(expert_id: current_user.expert.id) : @card.protocols
  end

  def permit_params
    params.require(:card).permit(:full_name, :gender, :member, :address, :comment, :phone, :work, :birthday, :image)
  end
end
