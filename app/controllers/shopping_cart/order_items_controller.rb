require_dependency "shopping_cart/application_controller"

module ShoppingCart
  class OrderItemsController < ApplicationController
    before_action :authenticate_user!
    before_action :get_order
    load_and_authorize_resource only: [:destroy, :update]

    def create
      model = params['model'].constantize
      product = model.find(params['id'])
      @current_order ||= current_user.orders.create
      item = @current_order.order_items.find_or_initialize_by(productable: product)
      item.update(quantity: params[:quantity], price: product.price)
      flash[:notice] = t('shopping_cart.cart_updated')
      redirect_to root_path
    end

    def update
      if @order_item.update(quantity: params[:quantity])
        flash[:notice] = t('shopping_cart.cart_updated')
        redirect_to root_path
      end
    end

    def destroy
      redirect_to root_path if @order_item.destroy
    end

    def destroy_items
      redirect_to root_path if @current_order.order_items.destroy_all
    end

    def discount
      discount = Discount.find_by_code(params[:code])
      if discount && !discount.order
        discount.update(order: @current_order)
        flash[:notice] = t('shopping_cart.valid_coupon', amount: discount.amount)
      else
        flash[:alert] = t('shopping_cart.invalid_coupon')
      end
      redirect_to root_path
    end

  end
end
