class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :update, :destroy, to: :modify
    can :modify, ShoppingCart::OrderItem, order_id: ShoppingCart::Order.current_order(user).id
  end
end
