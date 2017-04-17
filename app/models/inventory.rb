class Inventory < ApplicationRecord
  belongs_to :ingredient
  belongs_to :user
  belongs_to :unit

  validates :amount, presence: true
end
