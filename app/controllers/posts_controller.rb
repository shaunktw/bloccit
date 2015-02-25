class PostsController < ApplicationController
  
  def index
  	if params[:geolocation].blank?
  	  # if params[:tag]
     #    @posts = Post.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 10)
     #  else
      @posts = Post.visible_to(current_user).where("posts.created_at > ?", 10.days.ago).paginate(page: params[:page], per_page: 10)
      # end
    else
      geo = Geocoder.search(params[:geolocation]).first
      @posts = if geo.blank?
        flash[:error] = "Location are not valid"
        []
      else
        loc = Location.where(place_id: geo.data["place_id"]).first
        @posts = loc.blank? ? [] : loc.posts.paginate(page: params[:page], per_page: 20)
      end
    end 
  end
end

