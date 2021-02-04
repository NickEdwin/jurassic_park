class AddCageToDinosaurs < ActiveRecord::Migration[6.0]
  def change
    add_reference :dinosaurs, :cage, null: false, foreign_key: true
  end
end
