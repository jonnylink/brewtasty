class Ingredient < ApplicationRecord
  has_many :recipe_ingredients

  validates :name, presence: true
  validates :category, presence: true
end
