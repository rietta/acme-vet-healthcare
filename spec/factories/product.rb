# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph }
    published { [true, false].sample }
    category { %w[otc prescription restricted].sample }
  end
end
