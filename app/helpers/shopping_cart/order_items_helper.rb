module ShoppingCart
  module OrderItemsHelper
    def total_for_item(item)
      item.price * item.quantity
    end
  end
end
