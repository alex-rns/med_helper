class ChildrenController < ApplicationController
  before_action :set_user, only: %i[new index create]
  before_action :set_children, only: %i[index edit update]
  before_action :correct_user, only: [:new, :create, :edit, :update, :destroy]

  def new
    @child = current_user.children.build
  end

  def index; end

  def edit; end

  def update; end

  def create
    @child = current_user.children.build(child_params)
    if @child.save
      Vaccine.create!(child: @child)
      redirect_to user_children_path, success: 'Ребёнок добавлен'
    else
      flash.now[:danger] = 'Ребёнок не добавлен'
      render 'new'
    end
  end

  def destroy
    @child = Child.find(params[:id])
    @child.destroy
    redirect_to user_children_path, success: 'Ребёнок удалён из списка'
  end

  private

  def set_user
    @user = current_user
  end

  def set_children
    @children = current_user.children
  end

  def correct_user
    if get_patient?
    else
      redirect_to home_path
    end
  end

  def child_params
    params.require(:child).permit(:name, :birthday)
  end
end
