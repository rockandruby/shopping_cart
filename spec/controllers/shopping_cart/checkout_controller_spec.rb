require 'rails_helper'

module ShoppingCart
  RSpec.describe CheckoutController, type: :controller do
    routes { ShoppingCart::Engine.routes }

    let(:user) { create(:shopping_cart_user) }

    before(:each) do
      sign_in user
    end

    # it "should place order before checkout" do
    #   get :index
    #   expect(response).to redirect_to(main_app.root_path)
    # end
  end
end
