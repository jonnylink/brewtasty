class AddUseColToRecipeIngredients < ActiveRecord::Migration[5.0]
  def up
    add_column :recipe_ingredients, :use_id, :integer
    remove_column :ingredients, :use_id
  end

  def down
    remove_column :recipe_ingredients, :use_id
    add_column :ingredients, :use_id, :integer
  end
end
