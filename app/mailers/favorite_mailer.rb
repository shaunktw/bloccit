class FavoriteMailer < ActionMailer::Base
  default from: "shaunktw@gmail.com"

  def new_comment(user, post, comment)
    @user = user
    @post = post
    @comment = comment

    headers["Message-ID"] = "<comments/#{@comment.id}@sentro"
    headers["In-Reply-To"] = "<post/#{@post.id}@sentro"
    headers["References"] = "<post/#{@post.id}@sentro"

    mail(to: user.email, subject: "New comment on #{post.title}")
  end

end
