class CommentsController < ApplicationController

  def create
    @topic = Topic.find(params[:topic_id])
    @post  = @topic.posts.find(params[:post_id])
    @comments = @post.comments

    @comment = current_user.comments.build(comment_params)
    @comment.post = @post
    @new_comment = Comment.new

    if @comment.save
      flash[:notice] = "Comment was saved."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving your comment. Please try again."
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :post_id)
  end

end
