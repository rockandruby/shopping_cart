class CreateShoppingCartCreditCards < ActiveRecord::Migration[5.0]
  def change
    create_table :shopping_cart_credit_cards do |t|
      t.string :number
      t.integer :cvv
      t.integer :expiration_month
      t.integer :expiration_year
      t.string :first_name
      t.string :last_name
      t.belongs_to :order, index: true
    end
  end
end
