class RenameDirectionsColumn < ActiveRecord::Migration[5.0]
  def up
    rename_column :recipes, :directions, :notes
  end

  def down
    rename_column :recipes, :notes, :directions
  end
end
