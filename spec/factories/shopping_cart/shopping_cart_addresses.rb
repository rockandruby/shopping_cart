FactoryGirl.define do
  factory :shopping_cart_address, class: 'ShoppingCart::Address' do
    first_name FFaker::Name.first_name
    last_name FFaker::Name.last_name
    phone FFaker::PhoneNumber.short_phone_number
  end
end
