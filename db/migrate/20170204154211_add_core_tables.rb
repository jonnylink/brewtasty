class AddCoreTables < ActiveRecord::Migration[5.0]
  def up
    create_table :users do |t|
      t.string :username, null: false
      t.string :user_img
      t.text :bio
      t.integer :active, default: 1
      t.timestamps
    end

    create_table :recipes do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.text :directions
      t.integer :active, default: 1
      t.timestamps
    end
    add_index :recipes, :name, unique: true
    

    create_table :ingredients do |t|
      t.string :name, null: false
      t.string :category, null: false
      t.integer :active, default: 1
      t.timestamps
    end

    create_table :recipe_ingredients do |t|
      t.integer :recipe_id, null: false
      t.integer :ingredient_id, null: false
      t.float :amount, null: false
      t.string :unit, null: false
      t.integer :active, default: 1
      t.timestamps
    end

    create_table :ratings do |t|
      t.integer :user_id, null: false
      t.integer :recipe_id, null: false
      t.string :title
      t.integer :rating, null: false
      t.text :comment
      t.integer :active, default: 1
      t.timestamps
    end
  end

  def down
    drop_table :users
    drop_table :recipes
    drop_table :ingredients
    drop_table :recipe_ingredients
    drop_table :ratings
  end
end
