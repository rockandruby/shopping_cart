require 'rails_helper'

module ShoppingCart
  RSpec.describe OrderItem, type: :model do
    it { should validate_presence_of(:quantity) }
    it { should validate_numericality_of(:quantity).only_integer }
    it { should belong_to(:order) }
    it { should belong_to(:productable) }
  end
end
