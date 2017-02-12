class MoreBeerColumns < ActiveRecord::Migration[5.0]
  def up
    add_column :recipes, :batch_size, :float
    add_column :recipes, :boil_size, :float
    add_column :recipes, :boil_time, :integer
    add_column :recipes, :original_gravity, :float
    add_column :recipes, :final_gravity, :float
    add_column :recipes, :alcohol_by_volume, :float
    add_column :recipes, :bitterness, :float
    add_column :recipes, :color, :float
    add_column :recipes, :keg_temp, :float
    add_column :recipes, :storage_temp, :float
    add_column :recipes, :age_for, :float
  end

  def down
    remove_column :recipes, :batch_size
    remove_column :recipes, :boil_size
    remove_column :recipes, :boil_time
    remove_column :recipes, :original_gravity
    remove_column :recipes, :final_gravity
    remove_column :recipes, :alcohol_by_volume
    remove_column :recipes, :bitterness
    remove_column :recipes, :color
    remove_column :recipes, :keg_temp
    remove_column :recipes, :storage_temp
    remove_column :recipes, :age_for
  end
end
