class AddCustomerPaidAmountToBills < ActiveRecord::Migration[6.1]
  def change
    add_column :bills, :customer_paid_amount, :decimal
  end
end
