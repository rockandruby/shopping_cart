require 'rails_helper'

module ShoppingCart
  RSpec.describe Shipping, type: :model do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price) }
  end
end
