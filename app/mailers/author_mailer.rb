class AuthorMailer < ApplicationMailer
  default from: "blogger.me@gamil.com"

  def article_comment
    # @author = params[:author]
    @article = params[:article]
    @url = 'http://localhost:3000'
    mail(to: @article.author.email, subject: 'Your article commented!')
  end
end
