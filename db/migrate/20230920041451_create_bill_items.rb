class CreateBillItems < ActiveRecord::Migration[6.1]
  def change
    create_table :bill_items do |t|
      t.references :bill, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
