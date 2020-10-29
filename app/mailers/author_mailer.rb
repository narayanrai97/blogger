class AuthorMailer < ApplicationMailer
  default from: "blogger.me@gamil.com"

  layout "mailer"

  def article_comment(article)
    # @author = params[:author]
    @article = article
    @author = @article.author
    @url = 'http://localhost:3000'
    mail(to: @author.email, subject: 'Your article commented!')
  end
end
