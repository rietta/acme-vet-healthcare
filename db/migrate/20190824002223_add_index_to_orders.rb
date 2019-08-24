class AddIndexToOrders < ActiveRecord::Migration[6.0]
  def change
    add_index :orders, :status
    add_index :orders, :email
    add_index :orders, :phone
    add_index :orders, :zip
  end
end
