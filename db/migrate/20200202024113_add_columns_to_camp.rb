class AddColumnsToCamp < ActiveRecord::Migration[5.2]
  def change
    add_column :camps, :week_out_message, :text
    add_column :camps, :day_out_message, :text
  end
end
