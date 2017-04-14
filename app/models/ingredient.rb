class Ingredient < ApplicationRecord
  has_many :recipe_ingredients
  belongs_to :ingredient_category
  belongs_to :ingredient_use
  belongs_to :ingredient_kind
  belongs_to :degree
  belongs_to :origin

  validates :name, presence: true
  validates :category, presence: true
end
