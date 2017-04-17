class AddInventoryTables < ActiveRecord::Migration[5.0]
  def up
    create_table :inventories do |t|
      t.integer :user_id, null: false
      t.integer :ingredient_id, null: false
      t.float :amount, null: false
      t.integer :unit_id, null: false
      t.integer :active, default: 1
      t.timestamps
    end

    create_table :units do |t|
      t.string :name, null: false
      t.timestamps
    end
  end

  def down
    drop_table :inventories
    drop_table :units
  end
end
