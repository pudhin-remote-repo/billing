class CreateDenominations < ActiveRecord::Migration[6.1]
  def change
    create_table :denominations do |t|
      t.decimal :value
      t.integer :count
      t.references :bill, null: false, foreign_key: true

      t.timestamps
    end
  end
end
