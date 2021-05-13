class AuthorMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/author_mailer
  def article_comment
    comment = Comment.last
    AuthorMailer.article_comment(comment)
  end
end
