class CreateShoppingCartAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :shopping_cart_addresses do |t|
      t.string :first_name
      t.string :last_name
      t.string :city
      t.string :phone
      t.belongs_to :order, index: true
      t.text :details
      t.timestamps
    end
  end
end
