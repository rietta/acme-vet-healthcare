class AddRemoteApiDecisionFieldsToOrderProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :order_products, :decision, :string, index: true
    add_column :order_products, :decision_identifier, :string, index: true
    add_column :order_products, :decided_at, :datetime
  end
end
