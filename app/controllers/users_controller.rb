class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def show
  end

  def edit
  end

  def update
    @user.update(user_params)
    redirect_to @user, notice: "Comment was edited."
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:birthday, :image)
  end

end
