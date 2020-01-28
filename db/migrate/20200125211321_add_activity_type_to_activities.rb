class AddActivityTypeToActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :activity_type, :integer, default: 0
  end
end
