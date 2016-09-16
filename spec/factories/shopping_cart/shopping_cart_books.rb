FactoryGirl.define do
  factory :shopping_cart_book, class: '::Book' do
    title FFaker::Company.name
    price 10
  end
end
