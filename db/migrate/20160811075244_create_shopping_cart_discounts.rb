class CreateShoppingCartDiscounts < ActiveRecord::Migration[5.0]
  def change
    create_table :shopping_cart_discounts do |t|
      t.string :code, index: true, null: false
      t.integer :amount, default: 0
      t.belongs_to :order, index: true
      t.timestamps
    end
  end
end
