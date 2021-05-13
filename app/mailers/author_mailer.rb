class AuthorMailer < ApplicationMailer
  default from: "blogger.me@gamil.com"

  def article_comment(article, author)
    @author = author
    @article = article
    @url = 'http://localhost:3000'

    mail(to: @author.email, subject: 'Your article commented!')
  end
end
