FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { SecureRandom.hex(10) }
    role { :visitor }

    trait :veterinarian do
      vet_registration_number { 'VR0007' }
    end

    trait :admin do
      role { :admin }
    end
  end
end
