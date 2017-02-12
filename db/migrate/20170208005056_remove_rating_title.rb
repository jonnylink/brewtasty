class RemoveRatingTitle < ActiveRecord::Migration[5.0]
  def up
    remove_column :ratings, :title
  end

  def down
    add_column :ratings, :title, :string
  end
end
