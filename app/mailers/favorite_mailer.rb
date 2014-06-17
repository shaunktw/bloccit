class FavoriteMailer < ActionMailer::Base
  default from: "shaunktw@gmail.com"

  def new_comment(user, post, comment)
    @user = user
    @post = post
    @comment = comment

    headers["Message-ID"] = "<comments/#{@comment.id}@centroccit"
    headers["In-Reply-To"] = "<post/#{@post.id}@centroccit"
    headers["References"] = "<post/#{@post.id}@centroccit"

    mail(to: user.email, subject: "New comment on #{post.title}")
  end

end
