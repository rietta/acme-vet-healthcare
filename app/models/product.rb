class Product < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  validates :category, presence: true, inclusion: { in: %w(otc prescription restricted) }

  scope :published, -> { where(published: true) }
end
