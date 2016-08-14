module ShoppingCart
  class Order < ApplicationRecord
    belongs_to :user, class_name: ShoppingCart.user_class
    has_many :order_items
    has_one :discount

    delegate :amount, to: :discount, prefix: true, allow_nil: true

    def subtotal_price
      order_items.inject(0) do |sum, item|
        sum + item.quantity * item.price
      end
    end

    def self.current_order(user)
      Order.find_by(state: 'in_progress', user: user)
    end

  end
end
