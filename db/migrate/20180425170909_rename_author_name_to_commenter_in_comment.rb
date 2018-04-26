class RenameAuthorNameToCommenterInComment < ActiveRecord::Migration[5.1]
  def change
    rename_column :comments, :author_name, :commenter
  end
end
