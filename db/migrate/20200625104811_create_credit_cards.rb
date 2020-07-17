class CreateCreditCards < ActiveRecord::Migration[5.2]
  def change
    create_table :credit_cards do |t|
      t.references :user,null:false,foreign_key:true
      t.timestamps
      #追加
      t.string :customer_id, null: false
      t.string :card_id, null: false

      #削除
      #t.integer :card_number,null:false,unique:true
      #t.integer :expiration_date,null:false
      #t.integer :security_code,null:false
      
    end
  end
end
