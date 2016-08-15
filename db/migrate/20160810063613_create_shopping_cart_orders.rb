class CreateShoppingCartOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :shopping_cart_orders do |t|
      t.decimal :total_price, precision: 7, scale: 2
      t.string :state, default: 'in_progress'
      t.string :step
      t.belongs_to :user, index: true
      t.integer :order_items_count
      t.timestamp :completed_at
      t.timestamps
    end
  end
end
