class CreateTaggings < ActiveRecord::Migration[5.1]
  def change
    create_table :taggings do |t|
      t.reference :tags, foreign_key: true
      t.reference :articles, foreign_key: true

      t.timestamps
    end
  end
end
