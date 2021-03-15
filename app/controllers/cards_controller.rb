class CardsController < ApplicationController
  def new
   @expert = Expert.find(params[:expert_id])
   @card = @expert.build_card
  end

  def create
    @expert = Expert.find(params[:expert_id])
    @card = @expert.build_card(permit_params)
    if @card.save!
      redirect_to home_path
    else
      render 'new'
    end
  end

  def show
    @expert = Expert.find(params[:expert_id])
  end

  private

  def permit_params
    params.require(:card).permit(:full_name, :email, :gender, :address, :work, :member, :comment, :user_id)
  end
end
