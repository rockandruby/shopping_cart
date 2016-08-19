class CreateShoppingCartOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :shopping_cart_order_items do |t|
      t.integer :quantity
      t.decimal :price, precision: 5, scale: 2
      t.references :productable, polymorphic: true, index: {name: 'productable'}
      t.belongs_to :order, index: true
      t.timestamps
    end
  end
end
