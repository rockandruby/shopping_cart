require 'rails_helper'

module ShoppingCart
  RSpec.describe Discount, type: :model do
    it { should validate_presence_of(:amount) }
    it { should belong_to(:order) }
  end
end
