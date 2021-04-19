class ProtocolsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @card = Card.find(params[:card_id])
    @protocol = Protocol.new
  end

  def create
    @user = User.find(params[:user_id])
    @card = Card.find(params[:card_id])
    @protocol = @card.protocols.build(permit_params)
    if @protocol.save
      redirect_to user_card_path(@user, @card), success: "Протокол пациента создан"
    else
      flash.now[:error] = "При создании протокола пациента возникли ошибки"
      render 'new'
    end
  end

  def show
    @protocol = Protocol.find(params[:id])
  end

  private

  def permit_params
    params.permit(:complaint, :therapy, :diagnosis, :state, :symptom, :anamnesis_of_life, :medical_history, :type_of_inspection).merge(expert_id: current_user.expert.id)
  end
end
