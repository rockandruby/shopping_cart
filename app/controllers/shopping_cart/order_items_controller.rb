require_dependency "shopping_cart/application_controller"

module ShoppingCart
  class OrderItemsController < ApplicationController

    before_action :init_order

    def create
      model = params['model'].constantize
      product = model.find(params['id'])
      return unless product.respond_to?(:price)
      order_item = @current_order.order_items.find_by(productable: product)
      if order_item
        order_item.update(quantity: params[:quantity])
      else
        @current_order.order_items.create(productable: product,
                                          price: product.price, quantity: params[:quantity])
      end
      redirect_to root_path
    end

    def update
      item = OrderItem.find(params[:id])
      item.update(quantity: params[:quantity])
      redirect_to root_path
    end

    def destroy
      OrderItem.find(params[:id]).destroy
      redirect_to root_path
    end

    def destroy_items
      @current_order.order_items.destroy_all
      redirect_to root_path
    end

    def discount
      discount = Discount.find_by_code(params[:code])
      discount.update(order: @current_order) if discount
      redirect_to root_path
    end

    private

    def init_order
      order = current_user.orders.current_order
      @current_order = order.blank? ? Order.create(user: current_user) : order
    end

  end
end
