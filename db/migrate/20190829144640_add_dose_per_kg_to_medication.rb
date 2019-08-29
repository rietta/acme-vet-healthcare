class AddDosePerKgToMedication < ActiveRecord::Migration[6.0]
  def change
    add_column :medications, :dose_per_kg, :float
  end
end
