require "shopping_cart/engine"

module ShoppingCart
  mattr_accessor :user_class
  mattr_accessor :order_states
  mattr_accessor :order_steps
end
