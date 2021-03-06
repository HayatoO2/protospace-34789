class CommentsController < ApplicationController

  def create
    
    @comment = Comment.new(comment_param)

    if @comment.save
      redirect_to prototype_path(@comment.prototype.id)
      
    else
      @prototype = @comment.prototype
      @comments = @prototype.comments
      render "prototypes/show"
    end
  end

  private 

  def comment_param
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end

end
