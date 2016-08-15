module ShoppingCart
  class Address < ApplicationRecord
    belongs_to :order
  end
end
