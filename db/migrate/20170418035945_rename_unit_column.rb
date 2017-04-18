class RenameUnitColumn < ActiveRecord::Migration[5.0]
  def up
    rename_column :recipe_ingredients, :unit, :unit_id
  end

  def down
    rename_column :recipe_ingredients, :unit_id, :unit
  end
end
