FactoryGirl.define do
  factory :shopping_cart_order_item, class: 'ShoppingCart::OrderItem' do
    quantity 1
    price 10
    association :productable, factory: :shopping_cart_book
  end
end
