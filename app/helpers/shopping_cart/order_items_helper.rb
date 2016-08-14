module ShoppingCart
  module OrderItemsHelper
    def cart_empty?
      user = send("current_#{ShoppingCart.user_class.downcase}")
      order = Order.current_order(user)
      !order || order.order_items.blank?
    end

    def total_for_item(item)
      item.price * item.quantity
    end
  end
end
