class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string :name
      t.date :day
      t.time :start
      t.time :end
      t.integer :staff_needed
      t.references :guest_group, foreign_key: true
      t.timestamps
    end
  end
end
