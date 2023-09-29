class AddItemTaxRateToBillItems < ActiveRecord::Migration[6.1]
  def change
    add_column :bill_items, :item_tax_rate, :decimal
  end
end
