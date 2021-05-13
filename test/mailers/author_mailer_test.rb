require 'test_helper'

class AuthorMailerTest < ActionMailer::TestCase
  test "article_comment" do
    mail = AuthorMailer.article_comment
    assert_equal "New comment", mail.subject
  end
end 
