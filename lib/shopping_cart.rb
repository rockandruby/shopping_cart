require "shopping_cart/engine"

module ShoppingCart
  mattr_accessor :user_class

  def self.user
    send("current_#{ShoppingCart.user_class.downcase}")
  end
end
