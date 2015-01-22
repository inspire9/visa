class AddVoidedAt < ActiveRecord::Migration
  def change
    add_column :visa_tokens, :voided_at, :datetime
  end
end
