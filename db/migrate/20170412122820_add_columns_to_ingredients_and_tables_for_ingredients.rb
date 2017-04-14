class AddColumnsToIngredientsAndTablesForIngredients < ActiveRecord::Migration[5.0]
  def up
    remove_column :ingredients, :category

    add_column :ingredients, :ingredient_category, :integer
    add_column :ingredients, :origin, :integer
    add_column :ingredients, :kind, :integer
    add_column :ingredients, :product_id, :string
    add_column :ingredients, :alcohol_tolerance, :integer
    add_column :ingredients, :flocculation, :integer
    add_column :ingredients, :color, :float
    add_column :ingredients, :ppg, :float
    add_column :ingredients, :alpha, :string
    add_column :ingredients, :use, :integer

    add_column :recipe_ingredients, :time, :integer

    create_table :ingredient_categories do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :origins do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :ingredient_kinds do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :ingredient_uses do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :degrees do |t|
      t.string :name, null: false
      t.timestamps
    end


  end

  def down
    add_column :ingredients, :category, :string

    remove_column :ingredients, :origin
    remove_column :ingredients, :kind
    remove_column :ingredients, :product_id
    remove_column :ingredients, :alcohol_tolerance
    remove_column :ingredients, :flocculation
    remove_column :ingredients, :color
    remove_column :ingredients, :ppg
    remove_column :ingredients, :alpha
    remove_column :ingredients, :use

    remove_column :recipe_ingredients, :time

    drop_table :ingredient_categories
    drop_table :origins
    drop_table :ingredient_kinds
    drop_table :ingredient_uses
    drop_table :degrees
  end
end
