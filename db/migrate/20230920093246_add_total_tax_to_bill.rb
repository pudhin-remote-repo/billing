class AddTotalTaxToBill < ActiveRecord::Migration[6.1]
  def change
    add_column :bills, :total_tax, :decimal
  end
end
