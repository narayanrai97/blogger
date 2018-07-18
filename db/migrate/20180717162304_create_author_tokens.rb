class CreateAuthorTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :author_tokens do |t|
      t.string :token,               null: false, default: ""
      t.integer :author_id

      t.timestamps
    end
    
    add_index :author_tokens, :author_id
    add_index :author_tokens, :token
    add_index :author_tokens, [:author_id, :token]
  end
end


 