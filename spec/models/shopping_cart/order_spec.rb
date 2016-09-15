require 'rails_helper'

module ShoppingCart
  RSpec.describe Order, type: :model do
    it { should belong_to(:user) }
    it { should belong_to(:shipping) }
    it { should have_one(:discount) }
    it { should have_one(:address) }
    it { should have_one(:credit_card) }
    it { should have_many(:order_items) }
    it { should delegate_method(:amount).to(:discount).with_prefix(true) }
    it { should delegate_method(:price).to(:shipping).with_prefix(true) }

    it "should calculate total for order_items" do
      order = create(:shopping_cart_order)
      create_list(:shopping_cart_order_item, 3, price: 10, order: order)
      expect(order.subtotal_price).to eq(30)
    end

    it "should calculate order total price" do
      shipping = create(:shopping_cart_shipping, price: 20)
      order = create(:shopping_cart_order, shipping: shipping)
      create_list(:shopping_cart_order_item, 3, price: 10, order: order)
      expect(order.total_price).to eq(50)
    end

    context 'Order states managing' do
      it { expect(subject).to transition_from(:in_progress).to(:placed).on_event(:place_order) }
      it { expect(subject).to transition_from(:in_progress).to(:canceled).on_event(:cancel_order) }
    end
  end
end
