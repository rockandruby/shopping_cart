module ShoppingCart
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :current_user

    def current_user
      @user = User.take
    end
  end
end
