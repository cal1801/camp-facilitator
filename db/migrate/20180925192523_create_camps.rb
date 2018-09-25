class CreateCamps < ActiveRecord::Migration[5.2]
  def change
    create_table :camps do |t|
      t.string :name
      t.string :website
      t.string :phone_number

      t.timestamps
    end
  end
end
