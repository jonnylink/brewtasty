class Unit < ApplicationRecord
  has_many :ingredient_recipes
  has_many :inventories
end
