module ShoppingCart
  module OrderItemsHelper
    def cart_empty?
      order = @user.orders.current_order
      !order || order.order_items.blank?
    end

    def total_for_item(item)
      item.price * item.quantity
    end
  end
end
