class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :ratings
  has_many :recipes
  has_many :inventories

  validates :username, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true

  def active_for_authentication?
    super && active == 1
  end

  def inactive_message
    active == 1 ? super : :locked
  end

  def can_brew?(recipe)
    recipe_hash = recipe.recipe_ingredients.map {|recipe_ingredient| [recipe_ingredient.ingredient.name, recipe_ingredient.amount] }.to_h
    inventory_hash = inventories.map {|inventory_ingredient| [inventory_ingredient.ingredient.name, inventory_ingredient.amount] }.to_h

    return false if recipe_hash.count > inventory_hash.count
    recipe_hash.each do |recipe_ingredient, amount|
      return false if !inventory_hash.key?(recipe_ingredient)
      return false if amount > inventory_hash[recipe_ingredient]
    end
    return true
  end
end
