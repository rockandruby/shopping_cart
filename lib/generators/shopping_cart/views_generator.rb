module ShoppingCart
  class ViewsGenerator < Rails::Generators::Base
    source_root File.expand_path("../../../../app/views", __FILE__)

    desc 'copy engine views to app'

    def copy_views
      directory 'shopping_cart', 'app/views/shopping_cart'
    end

    desc 'copy engine layout to app'

    def copy_layout
      directory 'layouts/shopping_cart', 'app/views/layouts/shopping_cart'
    end
  end
end
