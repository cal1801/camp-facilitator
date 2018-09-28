class AddCampToGuestGroup < ActiveRecord::Migration[5.2]
  def change
    add_reference :guest_groups, :camp, foreign_key: true
  end
end
