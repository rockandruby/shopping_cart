FactoryGirl.define do
  factory :shopping_cart_order_item, class: 'ShoppingCart::OrderItem' do
    quantity 1
    price 10
  end
end
