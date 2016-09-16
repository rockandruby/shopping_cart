require_dependency "shopping_cart/application_controller"

module ShoppingCart
  class OrderItemsController < ApplicationController
    load_and_authorize_resource only: [:destroy, :update]

    before_action :get_order
    before_action :check_order, except: [:index, :create]

    def create
      model = params['model'].constantize
      product = model.find(params['id'])
      return unless product.respond_to?(:price) && OrderItem.new(quantity: params[:quantity]).valid?
      order_item = @current_order.order_items.find_by(productable: product)
      if order_item
        order_item.update(quantity: params[:quantity])
        flash[:notice] = t('shopping_cart.cart_updated')
      else
        @current_order.order_items.create(productable: product,
                                          price: product.price, quantity: params[:quantity])
        flash[:notice] = t('shopping_cart.item_added')
      end
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
      if discount && discount.order_id.nil?
        discount.update(order: @current_order)
        flash[:notice] = t('shopping_cart.valid_coupon', amount: discount.amount)
        redirect_to root_path
      else
        flash[:notice] = t('shopping_cart.invalid_coupon')
      end
    end

  end
end
