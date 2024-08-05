require 'rails_helper'

RSpec.describe "It creates an Items in the database", type: :request do
  before(:each) do 
    @brands = create_list(:brand, 10)
    @categories = create_list(:category, 10)
    @brand_count = @brands.count - 1
    @category_count = @categories.count - 1
    10.times do 
      random_brand_index = rand(0..@brand_count)
      random_category_index = rand(0..@category_count)
      create(
        :item, 
        brand: @brands[random_brand_index], 
        category: @categories[random_category_index]
      )
      @items = Item.all
    end 
  end
  describe  "Database Item Creation" do 
    it "Successfully creates an Item" do 
      name = "Item"
      price = 10.78
      quantity = 4
      brand_id = @brands[rand(0..@brand_count)].id
      category_id = @categories[rand(0..@category_count)].id
      post '/graphql', params: { query: mutation_string(name, price, quantity, brand_id, category_id) }
      expect(response).to be_successful
      reply = JSON.parse(response.body, symbolize_names: true)
      data = reply[:data]
      response_data = data[:createItem]
      response_object = response_data[:item]
      expect(response_object[:name]).to eq(name)
      expect(response_object[:price]).to eq(price)
      expect(response_object[:quantity]).to eq(quantity)
      response_brand = response_object[:brand]
      expect(response_brand[:id].to_i).to eq(brand_id)
      response_category = response_object[:category]
      expect(response_category[:id].to_i).to eq(category_id)
    end 
    it "It gracefully raises errors when passed a Float for Quantity argument" do 
      name = "Item"
      price = 10.98
      quantity = 5.0
      brand_id = @brands[rand(0..@brand_count)].id
      category_id = @categories[rand(0..@category_count)].id
      post '/graphql', params: { query: mutation_string(name, price, quantity, brand_id, category_id) }
      expect(response).to be_successful
      reply = JSON.parse(response.body, symbolize_names: true)
      errors = reply[:errors]
      expect(errors[0][:message]).to eq("Argument 'quantity' on InputObject 'CreateInput' has an invalid value (5.0). Expected type 'Int!'.")
    end 
  end 
  def mutation_string(
    name, 
    price, 
    quantity,
    brand_id,
    category_id
  )
    <<~GQL
      mutation {
        createItem (
          input: {
            name: "#{name}",
            price: #{price},
            quantity: #{quantity},
            brandId: #{brand_id},
            categoryId: #{category_id}
          }
        ) {
          item {
            id 
            name
            price
            quantity
            brand {
              id
              name
            }
            category {
              id
              title
            }
          }
          errors
        }
      }
    GQL
  end 
  Faker::UniqueGenerator.clear
end 