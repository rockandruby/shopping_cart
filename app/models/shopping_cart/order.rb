module ShoppingCart
  class Order < ApplicationRecord
    belongs_to :user, class_name: 'User'
    has_many :order_items
    scope :current_order, -> {find_by_state('in_progress')}
  end
end
