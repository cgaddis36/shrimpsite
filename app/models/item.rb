class Item < ApplicationRecord
  belongs_to :category
  belongs_to :brand
  validates_presence_of :name
  validates_presence_of :price
  validates_presence_of :quantity
end
