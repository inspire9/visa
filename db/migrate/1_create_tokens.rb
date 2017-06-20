superclass = ActiveRecord::VERSION::MAJOR < 5 ?
  ActiveRecord::Migration : ActiveRecord::Migration[4.2]
class CreateTokens < superclass
  def change
    create_table :visa_tokens do |t|
      t.string   :tokenable_type,   null: false
      t.integer  :tokenable_id,     null: false
      t.string   :client_id,        null: false
      t.string   :encrypted_secret, null: false
      t.datetime :last_requested_at
      t.timestamps null: false
    end

    add_index :visa_tokens, [:tokenable_type, :tokenable_id]
    add_index :visa_tokens, :client_id, unique: true
  end
end
