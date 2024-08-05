module Queries 
  module Items 
    class FetchByCategory < Queries::BaseQuery
      type [Types::ItemType], null: false 
      argument :category_id, Integer, required: true

      def resolve(category_id:)
        category = Category.find(category_id)
        category.items
      end 
    end 
  end 
end 