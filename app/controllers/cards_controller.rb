class CardsController < ApplicationController
  def show
    if current_user.expert.present?
      user = User.find(params[:user_id])
      @card = user.card
      @protocols = protocols
    else
     @card = current_user.card
     @protocols = protocols
    end
  end

  def edit
    @card = Card.find(params[:id])
  end

  def update
    card = Card.find(params[:id])
    card.update(permit_params)
    redirect_to user_path(current_user), success: "Ваша карта пациента изменена"
  end

  private

  def protocols
    if current_user.expert.present?
      @card.protocols.where(expert_id: current_user.expert.id)
    else
      @card.protocols
    end
  end

  def permit_params
      params.permit(:full_name, :gender, :member, :address, :comment, :email, :work)
  end
end
