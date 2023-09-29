class Customer < ApplicationRecord
  has_many :bills, dependent: :destroy
  # validates :email, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: 'Not a valid email' }
end
