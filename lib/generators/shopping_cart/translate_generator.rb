module ShoppingCart
  class TranslateGenerator < Rails::Generators::Base
    desc 'Create I18n file'

    def create_internationalization_file
      create_file "config/locales/shopping_cart.en.yml",
"en:
  shopping_cart:
    currency: $
    back: Back
    empty_cart: Your cart is empty
    product: Product
    price: Price
    qty: Quantity
    total: Total
    subtotal: Subtotal
    discount: Discount
    clear_cart: Clear your cart
    go_shopping: Proceed shopping
    coupon: Discount coupon
    checkout: Checkout
    address: Address
    complete: Complete
    code: Coupon code
    close: Close
    send: Send
    delivery: Delivery
    summary: Order summary
    place_order: Place order
    first_name: First name
    last_name: Last name
    city: City
    phone: Phone
    details: Details
    payment: Payment
    card_number: Card number
    item_added: You added item to cart
    cart_updated: You updated a cart
    valid_coupon: Your discount is %{amount}% from cart total price
    order_placed: Congratulations! Yout order placed successfully. Will get in touch asap."
    end
  end
end
