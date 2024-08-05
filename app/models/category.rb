class Category < ApplicationRecord
  has_many :items
  has_many :brands, :through => :items 
  validates_presence_of :title
  validates_uniqueness_of :title
end
