module ShoppingCart
  module OrdersHelper
    def order_total(order)
      subtotal = order.subtotal_price
      discount = order.discount_amount ? subtotal * (order.discount_amount.to_f / 100) : 0
      total = subtotal - discount
      {subtotal: subtotal, discount: discount, total: total}
    end
  end
end
