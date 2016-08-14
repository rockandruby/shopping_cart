Gem.loaded_specs['shopping_cart'].dependencies.each do |d|
  require d.name
end

require 'shopping_cart/engine'

module ShoppingCart
  class Engine < ::Rails::Engine
    isolate_namespace ShoppingCart
  end
end
