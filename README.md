# ShoppingCart
Simple gem which adds shopping cart and checkout ability to your shop.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'shopping_cart', github: 'rockandruby/shopping_cart'
```

## Usage
 Define root in your routes and run `rails g shopping_cart:config` to install shopping cart.

  Ensure you have flash messages in app/views/layouts/application.html.erb.
      For example:

        <p class="notice"><%= notice %></p>
        <p class="alert"><%= alert %></p>


 Firstly, gem depends on devise. Thus your app must have `current_{model_name}` method to perform
shopping cart functionality. For right now cart is accessible only for signed in users. Devise
added as a dependency for cart thus you don't need add devise to your gemfile. All you need - to install device.

 In `config/initializer`s you will find shopping_cart initializer. By default, name of your user model is
'User' but you can override it by changing `ShoppingCart.user_class = 'User'` with proper model name in
string format.

 By default, you have 4 steps for checkout:
 - address
 - payment
 - shipping
 - complete
 Payment and shipping are optional. In shopping cart initializer you have `ShoppingCart.order_steps = %i(shipping payment)`.
If you want to delete step, just delete it from array. If you want to delete optional steps at all, just
comment the array ans you will have only address and complete steps.

##### Notice!!! Order of elements in ShoppingCart.order_steps are equal to steps' order in your app.

##### Notice!!!! If you use shipping step you should create needed shippings e.g. ShoppingCart::Shipping.create(title:'Shipping title', price: 123).

 When you install shopping cart, you retrieve migrations for default steps. You can delete proper migration for
step you want to skip. Then run `rails db:migrate` to run migrations.

 Of course, you can add your own steps. Just put the name of your step to steps' array in initializer and
restart your app .

 Run `rails g shopping_cart:controller MySteps 'first_step' 'second_step'` to generate controller,
proper actions, views and routes for your steps. Don't forget that steps' names should be equal to names in
your initializer.

Don't forget that all entities should be in shopping_cart namespace. For instance, to create model for
your steps you suppose to run shopping_cart/YourModelName.

Your step controller will have 3 main methods:
- `check_step(:your_step)` which checks whether user able to proceed
   action and returns true/false.
- `update_step(:your_step)` which allows user to proceed to next step.
- `redirect_by_step(:your_step)` which redirects to next step.

Below simple example how it works:
 def your_step
  return redirect_to :back unless check_step(:your_step)
  //do some code
 end

 def add_your_step
   //do some code
   update_step(:your_step)
   redirect_by_step(:your_step)
 end
So

 You should add the following association for your user model "has_many :orders,
:class_name => 'ShoppingCart::Order'".

 Cart can process any product type quantity, you just need to add the following association to
your product model(e.g. Book, Magazine etc.)
"has_many :order_items, :class_name => 'ShoppingCart::OrderItem', as: :productable".
Also your model must have 'price' attribute.

You form should include following fields:
 hidden field "name='model' value='your model class'" e.g. "value='@book.class'".
 text field "name='quantity'" and hidden field "name='id' value='@book.id'". For instance,

 =form_tag(shopping_cart.order_items_path, class: 'form-inline') do
   =text_field_tag(:quantity, '', class: 'form-control', type: 'number', required: true, min: 1)
   =hidden_field_tag(:id, @book.id)
   =hidden_field_tag(:model, @book.class)
   =submit_tag

 = link_to('cart', shopping_cart.order_items_path)

 Submit your form on the following path shopping_cart.order_items_path.

 You can override views and layout for shopping cart by generating them to your project with
'rails g shopping_cart:views'.

 Also, you're able to use discount for your cart. Just create the proper discount, for example:
ShoppingCart::Discount.create(code: 'verification code', amount: 10), where amount is percentage.
If you don't need discount ability, delete the proper button from view.

I18n:
 Run 'rails g shopping_cart:translate' to generate internationalization file to your app.
