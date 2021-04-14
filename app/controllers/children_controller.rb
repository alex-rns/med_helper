class ChildrenController < ApplicationController
  before_action :set_user, only: [:new, :index, :create]
  before_action :set_children, only: [:index, :edit, :update]

  def new
    @child = Child.new
  end

  def index
  end

  def edit
  end

  def update
    @child.update(child_params)
    redirect_to user_children_path, notice: "Child was edited."
  end

  def create
    @child = Child.new(child_params)
    @child.user_id = current_user.id
    if @child.save
      Vaccine.create!(child_id: @child.id)
      redirect_to user_children_path, success: "Ребёнок добавлен"
    else
      flash.now[:danger] = "Ребёнок не добавлен"
      render "new"
    end
  end

  def destroy
    @child = Child.find(params[:id])
    @child.destroy
    redirect_to user_children_path, success: "Ребёнок удалён из списка"
  end

  private

  def set_user
    @user = current_user
  end

  def set_children
    @children = current_user.children
  end

  def child_params
    params.require(:child).permit(:name, :birthday)
  end
end
