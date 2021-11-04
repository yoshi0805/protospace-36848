class CommentsController < ApplicationController

  def create
    @comment = Comment.create(comment_params)
    @prototype = Prototype.find(params[:prototype_id])
    @comments = @prototype.comments.includes(:user)
    if @comment.save
      redirect_to prototype_path(params[:prototype_id])
    else
      render template: 'prototypes/show'
    end

  end

  def show
    @comments = Comment.find(params[prototype_id])
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end

end
