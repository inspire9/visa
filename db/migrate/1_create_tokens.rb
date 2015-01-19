class CreateTokens < ActiveRecord::Migration
  def change
    create_table :ephemera_tokens do |t|
      t.string  :tokenable_type,   null: false
      t.integer :tokenable_id,     null: false
      t.string  :client_id,        null: false
      t.string  :encrypted_secret, null: false
    end

    add_index :ephemera_tokens, [:tokenable_type, :tokenable_id]
    add_index :ephemera_tokens, :client_id, unique: true
  end
end
