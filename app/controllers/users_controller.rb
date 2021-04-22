class UsersController < ApplicationController
  before_action :set_user, only: %i[show]

  def show; end

  private

  def set_user
   @user = current_user
  end

  def user_params
    params.require(:user).permit(:birthday, :image)
  end
end
