require 'rails_helper'

RSpec.describe "It destroys an Item in the database", type: :request do
  before(:each) do 
    @brands = create_list(:brand, 3)
    @categories = create_list(:category, 3)
    @brand_count = @brands.count - 1
    @category_count = @categories.count - 1
    5.times do 
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
  describe  "Destroy Database Item" do 
    it "Successfully Destroys an Item" do 
      item = @items.first
      item_id = item.id
      item_count = Item.all.count
      post '/graphql', params: { query: mutation_string(item_id) }
      expect(response).to be_successful
      reply = JSON.parse(response.body, symbolize_names: true)
      data = reply[:data]
      response_data = data[:destroyItem]
      response_object = response_data[:item]
      expect(response_object[:name]).to eq(item.name)
      expect(Item.all.count).to be < item_count
    end 
  end 
  def mutation_string(
    item_id
  )
    <<~GQL
      mutation {
        destroyItem (
          input: {
            id: #{item_id}
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