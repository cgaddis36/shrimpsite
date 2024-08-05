# frozen_string_literal: true

module Types
  class ItemType < Types::BaseObject
    field :id, ID, null: false
    field :name, String
    field :price, Float
    field :quantity, Integer
    field :category_id, Integer, null: false
    field :brand_id, Integer, null: false
    field :brand, Types::BrandType 
    field :category, Types::CategoryType
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
