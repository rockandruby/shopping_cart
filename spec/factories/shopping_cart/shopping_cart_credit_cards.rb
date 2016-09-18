FactoryGirl.define do
  factory :shopping_cart_credit_card, class: 'ShoppingCart::CreditCard' do
    first_name FFaker::Name.first_name
    last_name FFaker::Name.last_name
    number 1111-1111-1111-1111
    cvv 123
    expiration_month 12
    expiration_year 2020
  end
end
