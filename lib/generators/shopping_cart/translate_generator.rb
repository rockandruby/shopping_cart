module ShoppingCart
  class TranslateGenerator < Rails::Generators::Base
    desc 'Create I18n file'

    def create_internationalization_file
      create_file "config/locals/shopping_cart.en.yml",
                  "ShoppingCart.user_class = 'User'\n#ShoppingCart.order_steps = %i(shipping payment)"
    end
  end
end
