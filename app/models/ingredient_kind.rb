class IngredientKind < ApplicationRecord
  has_many :ingredients

  validates :name, presence: true
end
