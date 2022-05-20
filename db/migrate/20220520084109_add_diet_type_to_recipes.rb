class AddDietTypeToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :diet_type, :string
    add_column :recipes, :cuisine, :string
    add_column :recipes, :recipe_tags, :string, index: true, array: true, default: []
  end
end
