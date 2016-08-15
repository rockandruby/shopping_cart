require_dependency "shopping_cart/application_controller"

module ShoppingCart
  class CheckoutController < ApplicationController
    before_action :get_order
    before_action :check_order

    layout 'shopping_cart/checkout'

    def index

    end

    def shipping

    end

    def payment

    end

    def create
      if states = ShoppingCart.order_states
        @current_order.send("run_#{states[0]}!")
      else
        @current_order.place_order!
      end
      flash[:notice] = t('order_placed')
      redirect_to '/'
    end

  end
end
