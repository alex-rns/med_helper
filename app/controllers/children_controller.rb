class ChildrenController < ApplicationController
  def new
    @user = current_user
    @child = Child.new
  end

  def index
    @user = current_user
    @children = current_user.children
  end

  def edit
    @children = current_user.children
  end

  def update
    @children = current_user.children
    @child.update(child_params)
    redirect_to user_children_path, notice: "Child was edited."
  end

  def create
    @user = current_user
    @child = Child.new(child_params)
    @child.user_id = current_user.id
    if @child.save
      Vaccine.create!(child_id: @child.id)
      redirect_to user_children_path, notice: "Thank you for @children!"
    else
      render "new"
    end
  end

  def child_params
    params.require(:child).permit(:name, :birthday)
  end
end
