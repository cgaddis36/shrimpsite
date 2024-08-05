require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "relationships" do 
    it { should have_many :items }
    it { should have_many(:brands).through(:items) }
  end 
  describe "validations" do 
    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of(:title) }
  end 
end
