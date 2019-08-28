class Order < ApplicationRecord
  enum status: { pending: 0, declined: 1, complete: 2 }
  belongs_to :user, required: false
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

  accepts_nested_attributes_for :order_products, allow_destroy: true

  def self.build(user:, cart:)
    order = Order.new(user: user)
    return order unless cart.any?

    cart.products.each do |product|
      order.order_products.build(product: product)
    end
    order
  end
end
