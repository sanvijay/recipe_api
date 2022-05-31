class AddIndexToRecipe < ActiveRecord::Migration[6.1]
  def change
    add_index :recipes, :slug, unique: true
  end
end
