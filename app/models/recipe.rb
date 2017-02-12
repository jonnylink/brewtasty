class Recipe < ApplicationRecord
  belongs_to :user
  has_many :ratings
  has_many :recipe_ingredients
  has_many :ingredients, :through => :recipe_ingredients

  validates :user_id, presence: true
  validates :name, uniqueness: true, presence: true
end