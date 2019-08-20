# frozen_string_literal: true

class ConvertLegacyPlainTextToRichText < ActiveRecord::Migration[6.0]
  def up
    Product.where.not(description: nil).each do |product|
      product.description = product[:description]
      product.save
    end
  end
end
