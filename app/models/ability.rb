class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :update, :destroy, to: :modify
    can :modify, ShoppingCart::OrderItem, order_id: user.orders.current_order.id
  end
end
