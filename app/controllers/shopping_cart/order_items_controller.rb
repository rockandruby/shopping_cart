require_dependency "shopping_cart/application_controller"

module ShoppingCart
  class OrderItemsController < ApplicationController
    load_and_authorize_resource only: [:destroy, :update]

    before_action :init_order

    def create
      model = params['model'].constantize
      product = model.find(params['id'])
      return unless product.respond_to?(:price) && OrderItem.new(quantity: params[:quantity]).valid?
      order_item = @current_order.order_items.find_by(productable: product)
      if order_item
        order_item.update(quantity: params[:quantity])
      else
        @current_order.order_items.create(productable: product,
                                          price: product.price, quantity: params[:quantity])
      end
      flash[:notice] = t('item_added')
      redirect_to root_path
    end

    def update
      flash[:notice] = t('cart_updated') if @order_item.update(quantity: params[:quantity])
      redirect_to root_path
    end

    def destroy
      @order_item.destroy
      redirect_to root_path
    end

    def destroy_items
      @current_order.order_items.destroy_all
      redirect_to root_path
    end

    def discount
      discount = Discount.find_by_code(params[:code])
      if discount
        discount.update(order: @current_order)
        flash[:notice] = t('valid_coupon', amount: discount.amount)
      end
      redirect_to root_path
    end

    private

    def init_order
      user = send("current_#{ShoppingCart.user_class.downcase}")
      order = user.orders.current_order
      @current_order = order.blank? ? Order.create(user: user) : order
    end

  end
end
