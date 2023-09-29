class ChangeQuantityColumnTypeInBillItems < ActiveRecord::Migration[6.1]
  def change
    change_column :bill_items, :quantity, :decimal, precision: 10, scale: 2
  end
end
