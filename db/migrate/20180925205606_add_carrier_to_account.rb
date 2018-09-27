class AddCarrierToAccount < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :carrier, :integer
  end
end
