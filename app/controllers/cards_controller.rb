class CardsController < ApplicationController
  before_action :set_card, only: [:edit, :update]

  def show
    if current_user.expert.present?
      user = User.find(params[:user_id])
      @card = user.card
    else
      @card = current_user.card
    end
    @protocols = protocols
  end

  def edit; end

  def update
    if @card.update(permit_params)
      redirect_to user_card_path(current_user, current_user.card), success: "Ваша карта пациента изменена"
    else
      flash.now[:error] = "Ваша карта пациента не изменена"
      render "edit"
    end
  end

  private

  def set_card
    @card = Card.find(params[:id])
  end

  def protocols
    current_user.expert.present? ? @card.protocols.where(expert_id: current_user.expert.id) : @card.protocols
  end

  def permit_params
    params.require(:card).permit(:full_name, :gender, :member, :address, :comment, :phone, :work, :birthday, :image)
  end
end
