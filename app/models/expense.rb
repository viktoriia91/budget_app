class Expense < ApplicationRecord
  belongs_to :category
  validates :name, :date, :amount, presence: true
end
