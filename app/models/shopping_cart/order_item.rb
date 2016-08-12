module ShoppingCart
  class OrderItem < ApplicationRecord
    belongs_to :productable, polymorphic: true
    belongs_to :order, counter_cache: true

    validates :quantity, presence: true
    validates :quantity, numericality: { only_integer: true }
  end
end
