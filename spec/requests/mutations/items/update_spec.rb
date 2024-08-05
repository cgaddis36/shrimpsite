require 'rails_helper'

RSpec.describe "It updates an Item in the database", type: :request do
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
  describe  "Database Item Updates" do 
    it "Successfully updates an Item" do 
      item = @items.first
      item_id = item.id
      name = item.name
      price = item.price
      new_quantity = item.quantity + 1
      post '/graphql', params: { query: mutation_string(item_id, name, price, new_quantity) }
      expect(response).to be_successful
      reply = JSON.parse(response.body, symbolize_names: true)
      data = reply[:data]
      response_data = data[:updateItem]
      response_object = response_data[:item]
      expect(response_object[:name]).to eq(name)
      expect(response_object[:price]).to eq(price)
      expect(response_object[:quantity]).to eq(new_quantity)
    end 
    it "It gracefully raises errors when passed a Float for Quantity argument" do 
      item = @items.first
      item_id = item.id
      name = item.name
      price = item.price
      new_quantity = 11.1
      category_id = @categories[rand(0..@category_count)].id
      post '/graphql', params: { query: mutation_string(item_id, name, price, new_quantity) }
      expect(response).to be_successful
      reply = JSON.parse(response.body, symbolize_names: true)
      errors = reply[:errors]
      expect(errors[0][:message]).to eq("Argument 'quantity' on InputObject 'UpdateInput' has an invalid value (11.1). Expected type 'Int!'.")
    end 
  end 
  def mutation_string(
    item_id,
    name, 
    price, 
    quantity
  )
    <<~GQL
      mutation {
        updateItem (
          input: {
            id: #{item_id},
            name: "#{name}",
            price: #{price},
            quantity: #{quantity},
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