require 'rails_helper'

describe 'Checkout process.' do
  let(:user) {create(:shopping_cart_user)}

  before(:each) do
    login_as(user)
    order = create(:shopping_cart_order, user: user)
    create(:shopping_cart_order_item, order: order)
    create(:shopping_cart_shipping)
  end

  it "should add address" do
    create_address
    expect(page).to have_content('Economy')
  end

  it "should add shipping" do
    create_address
    create_shipping
    expect(page).to have_selector('.new_credit_card')
  end

  it "should add credit card" do
    create_address
    create_shipping
    create_payment
    expect(page).to have_content(I18n.t('shopping_cart.place_order'))
  end

  it "should place order" do
    create_address
    create_shipping
    create_payment
    click_on I18n.t('shopping_cart.place_order')
    expect(page).to have_content(I18n.t('shopping_cart.order_placed'))
  end

end

def create_address
  visit engine_app.checkout_index_path
  within("#new_address") do
    fill_in 'address_first_name', with: 'Jimmy'
    fill_in 'address_last_name', with: 'Hendricks'
    fill_in 'address_city', with: 'London'
    fill_in 'address_phone', with: '123123123'
    click_on 'Create Address'
  end
end

def create_shipping
  within 'form' do
    choose('Economy')
    find('.btn-primary').click
  end
end

def create_payment
  within("#new_credit_card") do
    fill_in 'credit_card_first_name', with: 'Jimmy'
    fill_in 'credit_card_last_name', with: 'Hendricks'
    fill_in 'credit_card_number', with: '1111-1111-1111-1111'
    fill_in 'credit_card_cvv', with: '123'
    click_on 'Create Credit card'
  end
end