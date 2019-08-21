class Order < ApplicationRecord
  belongs_to :user
  has_many :order_products

  auto_strip_attributes(
    :name,
    :phone,
    :email,
    :address1,
    :address2,
    :city,
    :state,
    :zip
  )

  def self.build(user:, cart:)
    order = Order.new(user: user)
    return order unless cart.any?

    cart.products.each do |product|
      order.order_products.build(
        product: product,
        current_user: user
      )
    end
    order
  end
end
