module ShoppingCart
  class Order < ApplicationRecord
    belongs_to :user, class_name: ShoppingCart.user_class
    has_many :order_items
    has_one :discount
    scope :current_order, -> {find_by_state('in_progress')}

    delegate :amount, to: :discount, prefix: true, allow_nil: true

    def subtotal_price
      order_items.inject(0) do |sum, item|
        sum + item.quantity * item.price
      end
    end

  end
end
