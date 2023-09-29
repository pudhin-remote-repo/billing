class AddTaxToProduct < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :tax, :decimal
  end
end
