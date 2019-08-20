# frozen_string_literal: true

class Product < ApplicationRecord
  has_rich_text :description

  validates :name, presence: true, length: { maximum: 255 }
  validates :category, presence: true, inclusion: { in: %w[otc prescription restricted] }

  scope :published, -> { where(published: true) }
end
