require 'rails_helper'

RSpec.describe Brand, type: :model do
  describe "relationships" do 
    it { should have_many(:items).dependent(:destroy) }
    it { should have_many(:categories).through(:items) }
  end 
  describe "validations" do 
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end 
end
