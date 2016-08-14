require_dependency "shopping_cart/application_controller"

module ShoppingCart
  class CheckoutController < ApplicationController
    before_action :get_order
    before_action :check_order

    def create
      @current_order.update(state: 'completed', completed_at: Time.now,
                            total_price: @current_order.subtotal_price)
      flash[:notice] = t('order_placed')
      redirect_to '/'
    end

  end
end
