module ShoppingCart
  module OrderItemsHelper
    def cart_empty?
      order = @user.orders.current_order
      !order || order.order_items.blank?
    end
  end
end
