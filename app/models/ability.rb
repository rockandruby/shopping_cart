class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, ShoppingCart::OrderItem, order: user.current_order
  end
end
