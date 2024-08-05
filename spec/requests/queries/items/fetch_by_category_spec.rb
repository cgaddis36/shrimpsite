require 'rails_helper'

RSpec.describe "It returns all Items in the database related to the given Category", type: :request do
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
  describe  "Item database retrieval by Category ID" do 
    it "Successfully returns all Items by Category" do 
      category_id = @categories.first.id
      post '/graphql', params: { query: query_string(category_id) }
      expect(response).to be_successful
      reply = JSON.parse(response.body, symbolize_names: true)

      data = reply[:data]
      response_objects = data[:fetchByCategory]
      category = Category.find(category_id)
      expect(response_objects.count).to eq(category.items.count)
    end 
  end 
  def query_string(category_id)
    <<~GQL
      query {
        fetchByCategory(categoryId: #{category_id}) {
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
  Faker::UniqueGenerator.clear
end 