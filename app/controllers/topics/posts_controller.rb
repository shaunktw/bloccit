class Topics::PostsController < ApplicationController
 
  def show
    @topic = Topic.find(params[:topic_id])
    authorize @topic
    @post = Post.find(params[:id])

    @comments = @post.comments
    @comment = Comment.new
  end


  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
    authorize @post
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = current_user.posts.build(post_params)
    @post.topic = @topic
    authorize @post

    if @post.save
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post  = Post.find(params[:id])
    title = @post.title
    authorize @post

    if @post.destroy
      flash[:notice] = "\"#{title}\" was deleted successfully."
      redirect_to @topic
    else
      flash[:error] = "There was an error deleting the post."
      redirect_to :show
    end
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize @post
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize @post
    if @post.update_attributes(post_params)
      flash[:notice] = "Post was updated."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error updating the post. Please try again."
      render :edit
    end
  end

  def autocomplete_location
    location = Geocoder.search(params["term"])
    json = location.collect do |item| 
     { "id" => item.postal_code.to_s, 
       "label" => item.address, 
       "value" => item.address  
     }
   end
    render json: json
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image, :tag_list, :location_id, :geolocation)
  end

end
