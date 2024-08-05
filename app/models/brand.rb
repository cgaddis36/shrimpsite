class Brand < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :categories, :through => :items 
  validates_presence_of :name
  validates_uniqueness_of :name
end
