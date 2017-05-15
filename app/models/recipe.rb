class Recipe < ApplicationRecord
  belongs_to :user
  has_many :ratings
  has_many :recipe_ingredients
  has_many :ingredients, :through => :recipe_ingredients

  validates :name, presence: true, uniqueness: true

  def ibu_calc(recipe)
    aau = 0
    recipe.recipe_ingredients.each do |ingredient|
      if(!ingredient.amount.nil? && !ingredient.ingredient.alpha.nil?)
        aau = (ingredient.amount * ingredient.ingredient.alpha) + aau
      end
    end
    if (recipe.boil_gravity && recipe.boil_time && recipe.batch_size)
      fG = 1.65 * 0.000125**(recipe.boil_gravity - 1)
      fT = (1 - Math.log(10)**(-0.04 * recipe.boil_time)) / 4.15
      u = fG * fT
      ibu = aau * u * (75 / recipe.batch_size)
      (ibu).round(2)
    end
  end

  def color_calc(recipe)
    color = 0
    recipe.recipe_ingredients.each do |ingredient|
      if(!ingredient.amount.nil? && !ingredient.ingredient.color.nil?)
        color = ((ingredient.amount * ingredient.ingredient.color) / recipe.batch_size) + color
      end
    end
    color = 1.4922 * (color ** 0.6859)
    color > 50 ? 50 : (color).round(2)
  end

end
