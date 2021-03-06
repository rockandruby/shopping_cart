Gem.loaded_specs['shopping_cart'].dependencies.each do |d|
  require d.name
end

require 'shopping_cart/engine'

module ShoppingCart
  class Engine < ::Rails::Engine
    isolate_namespace ShoppingCart

    initializer "shopping_cart.assets.precompile" do |app|
      app.config.assets.precompile += %w( shopping_cart/* order_items.js.coffee order_items.scss)
    end

    initializer "model_core.factories", :after => "factory_girl.set_factory_paths" do
      FactoryGirl.definition_file_paths << File.expand_path('../../../spec/factories/shopping_cart', __FILE__) if defined?(FactoryGirl)
    end
  end
end
