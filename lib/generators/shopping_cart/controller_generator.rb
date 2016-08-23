module ShoppingCart
  class ControllerGenerator < Rails::Generators::Base
    desc 'Create own steps controller'
    argument :name, type: 'string', required: true
    def create_steps_controller
      create_file "app/controllers/shopping_cart/#{name.underscore}_controller.rb",
"module ShoppingCart
  class #{name}Controller < CheckoutController
    layout 'shopping_cart/checkout'

  end
end"
    end
  end
end
