module ShoppingCart
  class Address < ApplicationRecord
    belongs_to :order

    validates :first_name, :last_name, :phone, presence: true
  end
end
