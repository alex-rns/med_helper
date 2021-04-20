class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user, success: 'Ваш профиль был изменён'
    else
      flash.now[:danger] = 'Ваш профиль не был изменён'
      render 'edit'
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:birthday, :image)
  end
end
