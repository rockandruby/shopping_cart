module ShoppingCart
  class Shipping < ApplicationRecord
    validates :title, :price, presence: true
    validates_numericality_of :price
  end
end
