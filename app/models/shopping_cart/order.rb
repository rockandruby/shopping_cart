module ShoppingCart
  class Order < ApplicationRecord
    include AASM

    aasm column: :state do
      state :in_progress, initial: true
      state :placed
      state :canceled

      event :place_order do
        transitions from: :in_progress, to: :placed
      end

      event :cancel_order do
        transitions from: :in_progress, to: :canceled
      end
    end

    belongs_to :user, class_name: ShoppingCart.user_class
    has_many :order_items, dependent: :destroy
    has_one :discount, dependent: :destroy
    has_one :address, dependent: :destroy
    has_one :credit_card, dependent: :destroy
    belongs_to :shipping

    delegate :amount, to: :discount, prefix: true, allow_nil: true
    delegate :price, to: :shipping, prefix: true, allow_nil: true

    scope :current_order, -> { find_by_state('in_progress') }

    def subtotal_price
      order_items.inject(0) do |sum, item|
        sum + item.quantity * item.price
      end
    end

    def total_price
      subtotal = subtotal_price
      discount = discount_amount ? subtotal * (discount_amount.to_f / 100) : 0
      shipping = shipping_price || 0
      subtotal + shipping - discount
    end

  end
end
