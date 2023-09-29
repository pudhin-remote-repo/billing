class CreateBills < ActiveRecord::Migration[6.1]
  def change
    create_table :bills do |t|
      t.references :customer, null: false, foreign_key: true
      t.date :bill_date
      t.decimal :total_amount

      t.timestamps
    end
  end
end
