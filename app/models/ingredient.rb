class Ingredient < ApplicationRecord
  has_many :recipe_ingredients
  belongs_to :category
  belongs_to :use, optional: true
  belongs_to :kind, optional: true
  belongs_to :alcohol_tolerance, class_name: 'Degree', foreign_key: 'alcohol_tolerance_id', optional: true
  belongs_to :flocculation, class_name: 'Degree', foreign_key: 'flocculation_id', optional: true
  belongs_to :origin, optional: true

  validates :name, presence: true
end
