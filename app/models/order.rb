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
end
