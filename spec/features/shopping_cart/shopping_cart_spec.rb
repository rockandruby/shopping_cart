require 'rails_helper'

describe 'Shopping cart usage.' do
  before(:each) do
    create(:shopping_cart_book)
  end

  it "should offer to sign in before shopping" do
    visit engine_app.order_items_path
    expect(page).to have_content('sign')
  end

  context 'authed user' do
    let(:user) { create(:shopping_cart_user) }
    before(:each) do
      login_as(user)
    end

    it "should show empty cart" do
      visit root_path
      click_on 'cart'
      expect(page).to have_content(I18n.t('shopping_cart.empty_cart'))
    end

    context 'cart not empty' do
      before(:each) do
        @current_order = create(:shopping_cart_order, user: user)
        create(:shopping_cart_order_item, order: @current_order)
      end

      it 'should add item to cart' do
        visit root_path
        fill_in('quantity', with: 1)
        click_on 'Save changes'
        expect(page).to have_content(I18n.t('shopping_cart.cart_updated'))
        expect(page).to have_content(I18n.t('shopping_cart.clear_cart'))
        expect(page).to have_content(I18n.t('shopping_cart.go_shopping'))
        expect(page).to have_content(I18n.t('shopping_cart.discount'))
        expect(page).to have_content(I18n.t('shopping_cart.checkout'))
        expect(page).to have_content(I18n.t('shopping_cart.total'))
        expect(page).to have_content(I18n.t('shopping_cart.subtotal'))
      end

      context do
        before(:each) do
          visit engine_app.root_path
        end

        it "should update item quantity" do
          fill_in 'quantity', with: 1
          find('.update_qty').click
          expect(page).to have_content(I18n.t('shopping_cart.cart_updated'))
        end

        it "should clear cart" do
          click_on I18n.t('shopping_cart.clear_cart')
          expect(page).to have_content(I18n.t('shopping_cart.empty_cart'))
        end

        it "should proceed to checkout" do
          click_on I18n.t('shopping_cart.checkout')
          expect(page).to have_content(I18n.t('shopping_cart.address'))
        end
      end
    end
  end
end