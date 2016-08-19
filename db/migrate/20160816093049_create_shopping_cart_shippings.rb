class CreateShoppingCartShippings < ActiveRecord::Migration[5.0]
  def change
    create_table :shopping_cart_shippings do |t|
      t.string :title
      t.decimal :price, precision: 5, scale: 2
    end
  end
end
