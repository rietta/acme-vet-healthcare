class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description
      t.boolean :published, default: false, null: false, index: true
      t.string :category, null: false

      t.timestamps
    end
  end
end
