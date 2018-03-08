class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.text   :body
      t.references :author_id, foreign_key: true

      t.timestamps
    end
  end
end
