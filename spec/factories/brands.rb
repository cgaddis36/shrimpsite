FactoryBot.define do
  factory :brand do
    name { Faker::Creature::Animal.unique.name.capitalize }
  end
end
