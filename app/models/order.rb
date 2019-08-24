# frozen_string_literal: true

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
      order.order_products.build(
        product: product,
        current_user: user
      )
    end
    order
  end

  def process_restrictions
    order_products.restricted.unsubmitted_for_decision.each do |p|
      p.submit_for_decision_by_state_api
    end
    declined! if declined_by_government?
  end

  def declined_by_government?
    order_products.restricted.rejected.any?
  end

  def email_confirmation
    return if declined?

    OrderMailer.confirmation(order: @order).deliver_now
  end
end
