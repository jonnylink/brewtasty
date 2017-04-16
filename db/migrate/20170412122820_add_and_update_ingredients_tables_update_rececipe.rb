class AddAndUpdateIngredientsTablesUpdateRececipe < ActiveRecord::Migration[5.0]
  def up
    remove_column :recipes, :alcohol_by_volume
    remove_column :recipes, :color
    remove_column :recipes, :age_for
    remove_column :recipes, :bitterness
    add_column :recipes, :boil_gravity, :float

    change_column_null :recipe_ingredients, :amount, true
    change_column_null :recipe_ingredients, :unit, true

    remove_column :ingredients, :category

    add_column :ingredients, :category_id, :integer
    add_column :ingredients, :origin_id, :integer
    add_column :ingredients, :kind_id, :integer
    add_column :ingredients, :product_id, :string
    add_column :ingredients, :alcohol_tolerance_id, :integer
    add_column :ingredients, :flocculation_id, :integer
    add_column :ingredients, :color, :float
    add_column :ingredients, :ppg, :float
    add_column :ingredients, :alpha, :float
    add_column :ingredients, :use_id, :integer

    add_column :recipe_ingredients, :time, :integer

    create_table :categories do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :origins do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :kinds do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :uses do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :degrees do |t|
      t.string :name, null: false
      t.timestamps
    end


  end

  def down
    add_column :recipes, :alcohol_by_volume, :float
    add_column :recipes, :color, :float
    add_column :recipes, :age_for, :float
    add_column :recipes, :bitterness, :float
    remove_column :recipes, :boil_gravity

    change_column_null :recipe_ingredients, :amount, false
    change_column_null :recipe_ingredients, :unit, false

    add_column :ingredients, :category, :string

    remove_column :ingredients, :category_id
    remove_column :ingredients, :origin_id
    remove_column :ingredients, :kind_id
    remove_column :ingredients, :product_id
    remove_column :ingredients, :alcohol_tolerance_id
    remove_column :ingredients, :flocculation_id
    remove_column :ingredients, :color
    remove_column :ingredients, :ppg
    remove_column :ingredients, :alpha
    remove_column :ingredients, :use_id

    remove_column :recipe_ingredients, :time

    drop_table :categories
    drop_table :origins
    drop_table :kinds
    drop_table :uses
    drop_table :degrees
  end
end
