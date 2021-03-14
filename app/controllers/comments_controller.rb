class CommentsController < ApplicationController

  def new
    @comment = Comment.new(user: current_user, expert_id: params[:expert_id])
  end

  def create
    @comment = Comment.create(comment_params)
    if @comment.save
      redirect_to expert_path(@comment.expert), info: "Комментарий добавлен"
    else
      flash.now[:error] = "Комментарий не добавлен"
      render 'new'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :expert_id, :body, :rating)
  end
end
