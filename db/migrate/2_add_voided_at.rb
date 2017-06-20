superclass = ActiveRecord::VERSION::MAJOR < 5 ?
  ActiveRecord::Migration : ActiveRecord::Migration[4.2]
class AddVoidedAt < superclass
  def change
    add_column :visa_tokens, :voided_at, :datetime
  end
end
