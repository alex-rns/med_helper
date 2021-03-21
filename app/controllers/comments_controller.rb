class CommentsController < ApplicationController

  before_action :set_comment, only: [:edit, :update, :destroy]

  def new
    @comment = Comment.new(user: current_user, expert_id: params[:expert_id])
  end

  def create
    @comment = Comment.create(comment_params)
    if @comment.save
      redirect_to expert_path(@comment.expert), success: "Комментарий добавлен"
    else
      flash.now[:error] = "Комментарий не добавлен"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to @comment.expert, success: "Комментарий изменён"
    else
      flash.now[:error] = "Комментарий не изменён"
      render 'edit'
    end
  end

  def destroy
    @comment.destroy
    redirect_to @comment.expert, success: "Комментарий удалён"
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:user_id, :expert_id, :body, :rating, :recommendation)
  end
end
