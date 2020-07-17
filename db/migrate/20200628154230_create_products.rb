class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.references :user,              null: false, foreign_key: true
      t.string     :name,              null: false
      t.integer    :price,             null: false
      t.references :category,          null: false, foreign_key: true
      t.references :brand,             null: false, foreign_key: true
      t.references :product_condition, null: false, foreign_key: true
      t.references :size,              null: false, foreign_key: true
      t.integer    :dealing_status,    null: false, default: 0
      t.references :shipment,          null: false, foreign_key: true
      t.references :product_img,       null: false, foreign_key: true
      t.integer    :buyer_id
      t.text       :product_introduction
      t.timestamps
    end
  end
end
