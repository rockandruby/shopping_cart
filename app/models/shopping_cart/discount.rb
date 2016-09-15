module ShoppingCart
  class Discount < ApplicationRecord
    belongs_to :order

    validates :code, :amount, presence: true
  end
end
