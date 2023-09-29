class AddTotalItemTaxToBillItems < ActiveRecord::Migration[6.1]
  def change
    add_column :bill_items, :item_tax, :decimal
  end
end
