FactoryGirl.define do
  factory :shopping_cart_shipping, class: 'ShoppingCart::Shipping' do
    title 'Economy'
    price 10
  end
end
