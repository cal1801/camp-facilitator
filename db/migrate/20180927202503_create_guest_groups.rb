class CreateGuestGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :guest_groups do |t|
      t.string :name
      t.string :description
      t.datetime :arrives
      t.datetime :leaves

      t.timestamps
    end
  end
end
