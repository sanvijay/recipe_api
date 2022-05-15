class AddInstructionsIngredientsToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :instructions, :jsonb
    add_column :recipes, :ingredients, :string, index: true, array: true, default: []
    add_column :recipes, :ingredient_details, :jsonb
  end
end
