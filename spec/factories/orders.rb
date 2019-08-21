FactoryBot.define do
  factory :order do
    user { nil }
    name { "MyString" }
    email { "MyString" }
    phone { "MyString" }
    address1 { "MyString" }
    address2 { "MyString" }
    city { "MyString" }
    state { "MyString" }
    zip { "MyString" }
    status { 1 }
  end
end
