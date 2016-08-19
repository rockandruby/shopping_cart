module ShoppingCart
  class ConfigGenerator < Rails::Generators::Base
    desc 'Create shopping cart initializer file in config'

    def create_initializer_file
      create_file "config/initializers/shopping_cart.rb",
                  "ShoppingCart.user_class = 'User'\n#ShoppingCart.order_steps = %i(shipping payment)"
    end

    desc 'Copy necessary migrations to app'

    def copy_migrations
      rake 'shopping_cart:install:migrations'
    end

    desc 'Mounts engine routes to route.rb'

    def mount_routes
      inject_into_file 'config/routes.rb', before: "root" do
        "mount ShoppingCart::Engine => '/shopping_cart'\n"
      end
    end
  end
end
