# frozen_string_literal: true

class CardsController < ApplicationController
  before_action :find_card, only: %i[edit update]
  before_action :find_user, :get_card, only: %i[show], if: :get_doctor?
  before_action :find_patient_card, only: %i[show], if: :get_patient?
  before_action :correct_user, only: %i[edit update]

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

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_patient_card
    @card = current_user.card
  end

  def find_card
    @card = current_user.card
  end

  def protocols
    if current_user.doctor?
      @card.protocols.where(expert_id: current_user.expert.id)
    else
      @card.protocols
    end
  end

  def permit_params
    params.require(:card).permit(:full_name, :gender, :member, :address,
                                 :comment, :phone, :work, :birthday, :image)
  end
end
