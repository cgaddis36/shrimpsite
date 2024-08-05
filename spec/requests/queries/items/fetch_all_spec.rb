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
  describe "Item database retrieval" do 
    it "Succesfully returns all Items" do 
  
    end 
    it "It gracefully raises errors when incorrect fields are called" do 
      
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
  Faker::UniqueGenerator.clear
end