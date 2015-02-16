class PostsController < ApplicationController
  
  def index
  	if params[:tag]
      @posts = Post.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 10)
    else
      @posts = Post.visible_to(current_user).where("posts.created_at > ?", 10.days.ago).paginate(page: params[:page], per_page: 10)
    end
  end
end

