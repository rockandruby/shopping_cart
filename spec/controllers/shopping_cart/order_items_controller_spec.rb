require 'rails_helper'

module ShoppingCart
  RSpec.describe OrderItemsController, type: :controller do
    routes { ShoppingCart::Engine.routes }

    it "should sign in before shopping" do
      post :create
      expect(response).to redirect_to(main_app.new_user_session_path)
    end

    context 'Authed user' do
      let(:user) { create(:shopping_cart_user) }
      let(:order) { create(:shopping_cart_order, user: user) }

      before(:each) do
        sign_in user
      end

      it "should add item to cart" do
        book = create(:shopping_cart_book)
        post :create, model: book.class, id: book.id, quantity: 1
        expect(response).to redirect_to(root_path)
        expect(user.current_order.order_items_count).to eq(1)
      end

      it "update item qty" do
        item = create(:shopping_cart_order_item, order: order)
        patch :update, id: item, quantity: 2
        expect(order.order_items.take.quantity).to eq(2)
        expect(response).to redirect_to(root_path)
      end

      it "should delete item" do
        item = create(:shopping_cart_order_item, order: order)
        delete :destroy, id: item.id
        order.reload
        expect(order.order_items_count).to eq(0)
        expect(response).to redirect_to(root_path)
      end

      it "should delete all items" do
        create_list(:shopping_cart_order_item, 2, order: order)
        post :destroy_items
        order.reload
        expect(order.order_items_count).to eq(0)
        expect(response).to redirect_to(root_path)
      end

      it "should apply discount" do
        discount = create(:shopping_cart_discount, code: 123456)
        create_list(:shopping_cart_order_item, 2, order: order)
        post :discount, code: 123456
        expect(order.discount).to eq(discount)
        expect(response).to redirect_to(root_path)
      end
    end

  end
end
