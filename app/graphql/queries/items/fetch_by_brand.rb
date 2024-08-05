module Queries 
  module Items 
    class FetchByBrand < Queries::BaseQuery
      type [Types::ItemType], null: false 
      argument :brand_id, Integer, required: true

      def resolve(brand_id:)
        brand = Brand.find(brand_id)
        brand.items
      end 
    end 
  end 
end 