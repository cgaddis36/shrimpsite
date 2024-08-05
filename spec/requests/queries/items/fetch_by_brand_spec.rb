require 'rails_helper'

RSpec.describe "It returns all Items in the database related to the given Brand", type: :request do
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
  describe  "Item database retrieval by Brand ID" do 
    it "Successfully returns all Items by Brand" do 
      brand_id = @brands.first.id
      post '/graphql', params: { query: query_string(brand_id) }
      expect(response).to be_successful
      reply = JSON.parse(response.body, symbolize_names: true)

      data = reply[:data]
      response_objects = data[:fetchByBrand]
      brand = Brand.find(brand_id)
      expect(response_objects.count).to eq(brand.items.count)
    end 
  end 
  def query_string(brand_id)
    <<~GQL
      query {
        fetchByBrand(brandId: #{brand_id}) {
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