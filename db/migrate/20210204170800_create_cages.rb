class CreateCages < ActiveRecord::Migration[6.0]
  def change
    create_table :cages do |t|
      t.integer :capacity
      t.integer :power_status, default: 1

      t.timestamps
    end
  end
end
