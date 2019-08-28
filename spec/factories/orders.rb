FactoryBot.define do
  factory :order do
    user { nil }
    name { Faker::Name.name }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.phone_number }
    address1 { Faker::Address.street_address }
    address2 { 'Suite Test 172' }
    city { Faker::Address.city }
    state { Faker::Address.state }
    zip { Faker::Address.zip_code }
    status { 1 }
  end
end
