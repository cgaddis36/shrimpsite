module Mutations 
  module Items 
    class Update < ::Mutations::BaseMutation
      argument :id, Integer, required: true
      argument :name, String, required: true 
      argument :price, Float, required: true 
      argument :quantity, Integer, required: true 

      field :item, Types::ItemType, null: false 
      field :errors, [String], null: false
      def resolve(id:, name:, price:, quantity:)
        if item = Item.find(id)
          if updated_item = item.update(name: name, price: price, quantity: quantity)
            {
              item: item,
              errors: []
            }
          else 
            {
              item: item,
              errors: item.errors.full_messages
            }
          end 
        else 
          {
            item: nil,
            errors: ["Item does not exist."]
          }
        end 
      end 
    end 
  end 
end 