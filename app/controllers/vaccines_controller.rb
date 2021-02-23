class VaccinesController < ApplicationController
  before_action :set_user, only: [:show, :edit]

  def show
    @vaccines = @user.vaccine
  end

  def edit
    @vaccines = @user.vaccine
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
