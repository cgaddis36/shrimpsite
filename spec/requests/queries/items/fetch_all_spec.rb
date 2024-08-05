require 'rails_helper'

RSpec.describe "It returns all Items in the database", type: :request do
  before(:each) do 
    @brands = create_list(:brand, 10)
    @categories = create_list(:category, 10)
    brand_count = @brands.count - 1
    category_count = @categories.count - 1
    10.times do 
      random_brand_index = rand(0..brand_count)
      random_category_index = rand(0..category_count)
      create(
        :item, 
        brand: @brands[random_brand_index], 
        category: @categories[random_category_index]
      )
      @items = Item.all
    end 
  end 

  describe  "Item database retrieval" do 
    it "Successfully returns all Items" do 
      post '/graphql', params: { query: query_string }
      expect(response).to be_successful
      reply = JSON.parse(response.body, symbolize_names: true)

      data = reply[:data]
      response_objects = data[:fetchAllItems]

      expect(response_objects.count).to eq(@items.count)
    end 
    it "It gracefully raises errors when incorrect fields are called" do 
      post "/graphql", params: { query: incorrect_query_string }
      expect(response).to be_successful
      reply = JSON.parse(response.body, symbolize_names: true)

      errors = reply[:errors]

      expect(errors.count).to eq(2)
      expect(errors[0][:message]).to eq("Field 'brands' doesn't exist on type 'Item'")
      expect(errors[1][:message]).to eq("Field 'categories' doesn't exist on type 'Item'")
    end 
  end 
  def query_string
    <<~GQL
      query {
        fetchAllItems {
          id
          name 
          price 
          quantity 
          brand {
            name
          }
          category {
            title
          }
        }
      }
    GQL
  end 
  def incorrect_query_string
    <<~GQL
      query {
        fetchAllItems {
          name 
          price 
          quantity
          brands
          categories
        }
      }
    GQL
  end 
  Faker::UniqueGenerator.clear
end 