FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { SecureRandom.hex(10) }
  end
end
