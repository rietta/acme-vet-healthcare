class Product < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  validates :category, presence: true

  enum category: [:otc, :prescription, :restricted]
end
