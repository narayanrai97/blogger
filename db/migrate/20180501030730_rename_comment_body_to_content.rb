class RenameCommentBodyToContent < ActiveRecord::Migration[5.1]
  def change
    rename_column :comments, :body, :content
  end
end
