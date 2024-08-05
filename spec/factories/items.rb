FactoryBot.define do
  factory :item do
    name { Faker::Game.unique.title.capitalize }
    price { rand(0.50..60.00).round(2) }
    quantity { rand(1..20) }
    category { nil }
    brand { nil }
  end
end
