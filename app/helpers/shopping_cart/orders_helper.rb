module ShoppingCart
  module OrdersHelper
    def calculate_discount(order)
      order.discount_amount ? order.subtotal_price * (order.discount_amount.to_f / 100) : 0
    end
  end
end
