require 'rails_helper'

module ShoppingCart
  RSpec.describe CheckoutController, type: :controller do
    routes { ShoppingCart::Engine.routes }

    let(:user) { create(:shopping_cart_user) }

    before(:each) do
      sign_in user
    end

    it "should redirect to shopping cart" do
      get :index
      expect(response).to redirect_to(root_path)
    end

    context 'cart not empty' do
      let(:shipping) { create(:shopping_cart_shipping, price: 10) }

      before(:each) do
        order = create(:shopping_cart_order, user: user)
        create_pair(:shopping_cart_order_item, order: order)
      end

      it 'should render address form' do
        get :index
        should render_template('index')
      end

      it "should add address" do
        post :add_address, address: attributes_for(:shopping_cart_address)
        expect(user.current_order.address).not_to be_nil
        expect(response.status).to eq(302)
      end

      it "should render shipping form" do
        post :add_address, address: attributes_for(:shopping_cart_address)
        get :shipping
        should render_template('shipping')
      end

      it "should add shipping" do
        post :add_shipping, id: shipping.id
        expect(user.current_order.shipping).not_to be_nil
      end

      it "should render payment form" do
        post :add_address, address: attributes_for(:shopping_cart_address)
        post :add_shipping, id: shipping.id
        get :payment
        should render_template('payment')
      end

      it "should add payment" do
        post :add_payment, credit_card: attributes_for(:shopping_cart_credit_card)
        expect(user.current_order.credit_card).not_to be_nil
      end

      it "should place order" do
        post :add_address, address: attributes_for(:shopping_cart_address)
        post :add_shipping, id: shipping.id
        post :add_payment, credit_card: attributes_for(:shopping_cart_credit_card)
        post :create
        expect(flash[:notice]).to match(/success/)
        expect(response).to redirect_to('/')
      end
    end
  end
end
