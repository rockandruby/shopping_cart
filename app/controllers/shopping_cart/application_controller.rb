module ShoppingCart
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action "authenticate_#{ShoppingCart.user_class.downcase}!".to_sym
    alias_method :current_user, "current_#{ShoppingCart.user_class.downcase}".to_sym
    alias_method :authenticate_user!, "authenticate_#{ShoppingCart.user_class.downcase}!".to_sym

    rescue_from CanCan::AccessDenied do |exception|
      redirect_to '/', alert: exception.message
    end

  end
end
