class VaccinesController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :set_vaccine, only: [:show, :edit, :update]

  def show
  end

  def edit
  end

  def update
    @vaccines.update(vaccines_params)
    redirect_to user_vaccine_path(@user)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_vaccine
    @vaccines = @user.vaccine
  end

  def vaccines_params
    params.permit(:hepatitis_a_1w, :hepatitis_a_2w)
  end
end
