FactoryGirl.define do
  factory :shopping_cart_user, class: '::User' do
    email FFaker::Internet.email
    password 123456
  end
end
