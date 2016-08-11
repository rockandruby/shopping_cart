module ShoppingCart
  class OrderItem < ApplicationRecord
    belongs_to :productable, polymorphic: true
    belongs_to :order, counter_cache: true
  end
end
