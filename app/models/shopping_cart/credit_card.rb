module ShoppingCart
  class CreditCard < ApplicationRecord
    belongs_to :order

    validates :first_name, :last_name, :number, :cvv, :expiration_month,
              :expiration_year, presence: true
    validates :cvv, numericality: { only_integer: true }
  end
end
