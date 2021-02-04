class CreateDinosaurs < ActiveRecord::Migration[6.0]
  def change
    create_table :dinosaurs do |t|
      t.string :name
      t.string :species
      t.string :food_type

      t.timestamps
    end
  end
end
