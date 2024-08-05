FactoryBot.define do
  factory :item do
    name { "MyString" }
    price { 1.5 }
    quantity { 1 }
    category { nil }
    brand { nil }
  end
end
