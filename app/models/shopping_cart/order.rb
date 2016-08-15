module ShoppingCart
  class Order < ApplicationRecord
    include AASM

    aasm :order_states, column: :state do
      state :in_progress, initial: true
      state :canceled
      order_states = ShoppingCart.order_states
      if order_states
        order_states.each_with_index do |order_state, index|
          state order_state.to_sym
          event "run_#{order_state.to_s}".to_sym do
            if order_state == order_states.first
              transitions from: :in_progress, to: order_state.to_sym, after: [:arrange_order]
            else
              transitions from: order_state[index - 1], to: order_state.to_sym
            end
          end
        end
      else
        state :placed
        event :place_order do
          transitions from: :in_progress, to: :placed, after: [:arrange_order]
        end
      end
      event :cancel_order do
        transitions from: :in_progress, to: :canceled
      end
    end

    aasm :order_steps, column: :step do
      state :address, initial: true
      state :confirm
      order_steps = ShoppingCart.order_steps
      if order_steps
        order_steps.each_with_index do |order_step, index|
          state order_step.to_sym
          event "run_#{order_step.to_s}".to_sym do
            if order_step == order_steps.first
              transitions from: :address, to: order_step.to_sym
            else
              transitions from: order_step[index - 1], to: order_step.to_sym
            end
          end
        end
      else
        event :complete do
          transitions from: :address, to: :confirm
        end
      end
    end

    belongs_to :user, class_name: ShoppingCart.user_class
    has_many :order_items
    has_one :discount

    delegate :amount, to: :discount, prefix: true, allow_nil: true

    def subtotal_price
      order_items.inject(0) do |sum, item|
        sum + item.quantity * item.price
      end
    end

    def self.current_order(user)
      Order.find_by(state: 'in_progress', user: user)
    end

    private

    def arrange_order
      update(completed_at: Time.now, total_price: subtotal_price)
    end

  end
end
