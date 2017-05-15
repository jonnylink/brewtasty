class AddUseColToRecipeIngredients < ActiveRecord::Migration[5.0]
  def up
    add_column :recipe_ingredients, :use, :string
  end

  def down
    remove_column :recipe_ingredients, :use
  end
end
