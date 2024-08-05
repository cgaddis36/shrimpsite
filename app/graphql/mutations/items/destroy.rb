module Mutations 
  module Items 
    class Destroy < ::Mutations::BaseMutation
      argument :id, Integer, required: true

      field :item, Types::ItemType, null: false 
      field :errors, [String], null: false
      def resolve(id:)
        if item = Item.find(id)
          if item.destroy!
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