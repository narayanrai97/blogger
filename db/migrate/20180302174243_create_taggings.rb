class CreateTaggings < ActiveRecord::Migration[5.1]
  def change
    create_table :taggings do |t|
      t.references :tag_id, foreign_key: true
      t.references :article_id, foreign_key: true

      t.timestamps
    end
  end
end
