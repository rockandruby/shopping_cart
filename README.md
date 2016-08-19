# ShoppingCart
Simple gem which adds shopping cart to your shop with some tricks.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'shopping_cart', github: 'rockandruby/shopping_cart'
```

run bin/rake shopping_cart:install:migrations

## Usage
Firstly, gem depends devise gem. Thus you app must have current_{model_name} method to perform
shopping cart functionality. For right now cart is accessible only gor signed in users.


Create shopping_cart initializer in config/initializers and add the following row inside: ShoppingCart.user_class = Model.
You can specify any model which represents your user, e.q. 'User', 'Customer' etc. Model should be in string format.
Then run 'bin/rake shopping_cart:install:migrations' to copy migrations to your app and 'bin/rake db:migrate'

You should the following association for your user model "has_many :orders, :class_name => 'ShoppingCart::Order', foreign_key: 'user_id'".
Mount to your routes.rb mount ShoppingCart::Engine => "/shopping_cart"

Add Rails.application.config.assets.precompile += %w( shopping_cart/*) to config/initializers/assets.rb

Cart can process any product type quantity, you just need to add the following association to your product model(e.g. Book, Magazine etc.)
"has_many :order_items, :class_name => 'ShoppingCart::OrderItem', as: :productable". Also your model must have 'price' attribute.

You form should include following fields:
 hidden field "name='model' value='your model class'" e.g. "value='@book.class'".
 "name='quantity'".
 hidden field "name='id' value='@book.id'".

Submit your form on the following path shopping_cart.order_items_path.

If you want to add a discount do this: ShoppingCart::Discount.create(code: 123, amount: 10), amount means %