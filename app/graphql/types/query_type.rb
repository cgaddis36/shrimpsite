# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField
    field :fetch_all_items, resolver: Queries::Items::FetchAll
    field :fetch_by_brand, resolver: Queries::Items::FetchByBrand
    field :fetch_by_category, resolver: Queries::Items::FetchByCategory
  end
end
