require 'rails_helper'

module ShoppingCart
  RSpec.describe Address, type: :model do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:phone) }
    it { should belong_to(:order) }
  end
end
