# ShoppingCart
Simple gem which adds shopping cart and checkout ability to your shop.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'shopping_cart', github: 'rockandruby/shopping_cart'
```

## Usage
 Define root in your routes and run 'rails g shopping_cart:config' to install shopping cart.

 Firstly, gem depends on devise. Thus your app must have current_{model_name} method to perform
shopping cart functionality. For right now cart is accessible only for signed in users. Devise
added as a dependency for cart thus you don't need add devise to your gemfile. All you need - to generate
proper model for devise.

 In config/initializers you will find shopping_cart initializer. By default, name of your user model is
'User' but you can override it by changing ShoppingCart.user_class = 'User' with proper model name in
string format.

 By default, you have 4 steps for checkout: address, payment, shipping and complete. Payment and shipping
are optional. In shopping cart initializer you have ShoppingCart.order_steps = %i(shipping payment) array.
If you want to delete step, just delete it from array. If you want to delete optional steps at all, just
comment the array ans you will have only address and complete steps.

 Of course, you can add your own steps. Just put the name of your step to steps' array. In your routes
you should create a route in the following format:

   namespace 'shopping_cart' do
     get '/checkout/foo', to: 'my_steps#foo', as: 'foo'
   end

where 'foo' - the name of your step and 'my_steps' - your steps controller. Run
'rails g shopping_cart:controller MySteps' to generate controller for your steps. Don't forget that
all entities should be in shopping_cart namespace. For instance, to create model for your steps you
suppose to run shopping_cart/YourModelName.

 When you install shopping cart, you retrieve migrations for default steps. You can delete proper migration for
step you want to skip. Then run rails db:migrate to run migrations.

 You should sign the following association for your user model "has_many :orders,
:class_name => 'ShoppingCart::Order'".

 Cart can process any product type quantity, you just need to add the following association to
your product model(e.g. Book, Magazine etc.)
"has_many :order_items, :class_name => 'ShoppingCart::OrderItem', as: :productable".
Also your model must have 'price' attribute.

You form should include following fields:
 hidden field "name='model' value='your model class'" e.g. "value='@book.class'".
 "name='quantity'".
 hidden field "name='id' value='@book.id'".

 Submit your form on the following path shopping_cart.order_items_path.

 You can override views and layout for shopping cart by generating them to your project with
'rails g shopping_cart:views'.

I18n:
 Run 'rails g shopping_cart:translate' to generate internationalization file to your app.