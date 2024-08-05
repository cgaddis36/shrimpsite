# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_item, mutation: Mutations::Items::Create
    field :update_item, mutation: Mutations::Items::Update
    field :destroy_item, mutation: Mutations::Items::Destroy
  end
end
