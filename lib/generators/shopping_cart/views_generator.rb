module ShoppingCart
  class ViewsGenerator < Rails::Generators::Base
    source_root File.expand_path("../../../../app/views", __FILE__)

    desc 'copy engine views to app'

    def copy_views
      directory 'shopping_cart', 'app/views/shopping_cart'
    end
  end
end
