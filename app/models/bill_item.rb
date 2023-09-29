class BillItem < ApplicationRecord
  belongs_to :bill
  belongs_to :product

  after_create :calculate_and_set_tax

  def calculate_and_set_tax
    self.item_tax_rate = product.tax
    self.item_price = product.price
    self.item_tax = ((item_price * quantity) / 100) * item_tax_rate
  end
end

