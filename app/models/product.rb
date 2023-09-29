class Product < ApplicationRecord
  has_many :bill_items, dependent: :destroy
  has_many :bills, through: :bill_items

  validates :price, :name, :tax, presence: true
  validates :name, uniqueness: true
end
