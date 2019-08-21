FactoryBot.define do
  factory :order_product do
    order { nil }
    product { nil }
    prescription_number { "MyString" }
  end
end
