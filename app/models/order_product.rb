class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product

  auto_strip_attributes :prescription_number
end
