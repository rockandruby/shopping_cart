module ShoppingCart
  class ControllerGenerator < Rails::Generators::Base
    desc 'Create own steps controller with proper actions'
    argument :name, type: 'string', required: true
    argument :steps, type: 'array', required: true
#     def create_steps_controller
#       html = ''
#       steps.each do |step|
#         html +=
#           "\tdef #{step}\n\tend\n\tdef add_#{step}\n\tend\n\t"
#       end
#
#       create_file "app/controllers/shopping_cart/#{name.underscore}_controller.rb",
# "module ShoppingCart
#   class #{name}Controller < CheckoutController
#     layout 'shopping_cart/checkout'
#
#     #{html}
#   end
# end"
#     end

    desc 'create routes for your steps'

    def create_routes
      html = ''
      steps.each do |step|
        html +=
            "get '/checkout/#{step}', to: '#{name.underscore}##{step}'\n
             post '/checkout/add_#{step}', to: '#{name.underscore}#add_#{step}'\n"
      end
      inject_into_file 'config/routes.rb', after: "lol" do
        "\nnamespace 'shopping_cart' do end"
      end
    end
  end
end
