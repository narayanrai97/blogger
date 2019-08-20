class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.string :title
      t.text :body
      t.boolean :posted, default: false
      t.string :message_type, default: :info
      t.string :titulo
      t.text :cuerpo

      t.timestamps
    end
  end
end
