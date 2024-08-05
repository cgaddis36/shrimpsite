module Mutations 
  module Items 
    class Create < ::Mutations::BaseMutation
      argument :name, String, required: true 
      argument :price, Float, required: true 
      argument :quantity, Integer, required: true 
      argument :brand_id, Integer, required: true 
      argument :category_id, Integer, required: true 

      field :item, Types::ItemType, null: false 
      field :errors, [String], null: false
      def resolve(name:, price:, quantity:, brand_id:, category_id:)
        item = Item.new(
          name: name,
          price: price,
          quantity: quantity,
          brand_id: brand_id,
          category_id: category_id
        )
        if item.save
          {
            item: item,
            errors: []
          }
        else 
          {
            item: nil,
            errors: item.errors.full_messages
          }
        end 
      end 
    end 
  end 
end 