class CreateProductImgs < ActiveRecord::Migration[5.2]
  def change
    create_table :product_imgs do |t|
      t.string :image,        null: false
      t.timestamps
    end
  end
end
