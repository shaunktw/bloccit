class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  default_scope { order('created_at DESC') }

  after_create :send_favorite_emails

  private

  def send_favorite_emails
    self.post.favorites.each do |favorite|
      if favorite.user_id != self.user_id && favorite.user.email_favorites?
        FavoriteMailer.new_comment(favorite.user, self.post, self).deliver
      end
    end
  end

end
