8.times do 
  Brand.create(
    name: Faker::Creature::Animal.unique.name.capitalize
  )
end 
puts "#{Brand.all.count} Brands Created"

10.times do 
  Category.create(
    title: Faker::Game.unique.genre.capitalize
  )
end 
puts "#{Category.all.count} Categories Created"

category_max_range = (Category.all.count)
brand_max_range = (Brand.all.count)

20.times do 
  random_category = rand(1..category_max_range)
  random_brand = rand(1..brand_max_range)
  random_price = rand(0.01..60.00).round(2)
  random_quantity = rand(1..25)
  Item.create(
    name: Faker::Game.unique.title,
    price: random_price,
    quantity: random_quantity,
    category_id: random_category,
    brand_id: random_brand
  )
end 

puts "#{Item.all.count} Items Created"
Faker::UniqueGenerator.clear