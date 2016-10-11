require_dependency "shopping_cart/application_controller"

module ShoppingCart
  class CheckoutController < ApplicationController
    before_action :authenticate_user!
    before_action :init_checkout
    before_action :init_address, only: [:index, :add_address]
    before_action :init_payment, only: [:payment, :add_payment]
    before_action :check_complete, only: [:complete, :create]

    layout 'shopping_cart/checkout'

    def index
      redirect_to root_path unless @current_order.order_items.any?
    end

    def add_address
      return render :index unless @address.update(address_params)
      @current_order.update(step: 0) unless @current_order.step
      return redirect_to '/shopping_cart/checkout/complete' unless @steps
      redirect_to "/shopping_cart/checkout/#{@steps[0]}"
    end

    def shipping
      redirect_to :back unless check_step(:shipping)
      @shippings = Shipping.all
    end

    def payment
      redirect_to :back unless check_step(:payment)
    end

    def add_shipping
      unless params[:id]
        flash[:alert] = t('shopping_cart.choose_shipping')
        return redirect_to :back
      end
      shipping = Shipping.find(params[:id])
      @current_order.update(shipping: shipping)
      update_step(:shipping)
      redirect_by_step(:shipping)
    end

    def add_payment
      return render :payment unless @credit_card.update(payment_params)
      update_step(:payment)
      redirect_by_step(:payment)
    end

    def create
      @current_order.place_order
      @current_order.update(completed_at: Time.now, total_price: @current_order.total_price)
      flash[:notice] = t('shopping_cart.order_placed')
      redirect_to '/'
    end

    private

    def init_checkout
      get_order
      redirect_to root_path unless @current_order
      @steps = ShoppingCart.order_steps
    end

    def init_address
      @address = Address.find_or_initialize_by(order: @current_order)
    end

    def init_payment
      @credit_card = CreditCard.find_or_initialize_by(order: @current_order)
    end

    def address_params
      params.require(:address).permit(:first_name, :last_name, :city, :phone, :details)
    end

    def payment_params
      params.require(:credit_card).permit(:first_name, :last_name, :number, :cvv,
                                          :expiration_month, :expiration_year)
    end

    def check_step(current_step)
      @steps.index(current_step) <= @current_order.step if @current_order.step
    end

    def update_step(current_step)
      if @current_order.step == @steps.index(current_step)
        @current_order.update(step: @current_order.step + 1)
      end
    end

    def check_complete
      if @steps
        redirect_to :back unless @current_order.step == @steps.count
      else
        redirect_to :back unless @current_order.address
      end
    end

    def redirect_by_step(current_step)
      if !@steps || current_step == @steps.last
        return redirect_to '/shopping_cart/checkout/complete'
      end
      redirect_to "/shopping_cart/checkout/#{@steps[@steps.index(current_step) + 1]}"
    end
  end
end
