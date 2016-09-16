module ShoppingCart
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action "authenticate_#{ShoppingCart.user_class.downcase}!".to_sym
    alias_method :current_user, "current_#{ShoppingCart.user_class.downcase}".to_sym

    rescue_from CanCan::AccessDenied do |exception|
      redirect_to '/', alert: exception.message
    end

    protected

    def get_order
      @current_order = Order.find_or_create_by(user: current_user, state: 'in_progress')
    end

    def check_order
      redirect_to root_path unless @current_order && @current_order.order_items_count > 0
    end

  end
end
