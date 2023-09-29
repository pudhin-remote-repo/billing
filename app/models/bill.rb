class Bill < ApplicationRecord
  belongs_to :customer
  has_many :products, dependent: :destroy
  has_many :bill_items, dependent: :destroy
  has_many :products, through: :bill_items
  has_many :denominations

  validates :customer_id, presence: true
  validates :customer_paid_amount, presence: true, numericality: { allow_float: true }

  # accepts_nested_attributes_for :denominations
  accepts_nested_attributes_for :bill_items, allow_destroy: true
  after_create :calculate_total_amount_and_tax

  def calculate_total_amount_and_tax
    total_amount = bill_items.sum { |item| item.quantity * item.product.price }
    total_tax_amount = bill_items.sum { |item| item.item_tax }
    update(total_amount: total_amount, total_tax: total_tax_amount)
  end
end
