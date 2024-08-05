FactoryBot.define do
  factory :category do
    title { Faker::Fantasy::Tolkien.unique.location.capitalize }
  end
end
