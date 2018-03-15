class AddAuthorRefToArticles < ActiveRecord::Migration[5.1]
  def change
    add_reference :articles, :author, foreign_key: true
    Article.reset_column_information
  end
end
