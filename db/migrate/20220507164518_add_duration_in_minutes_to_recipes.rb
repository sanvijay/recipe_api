class AddDurationInMinutesToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :duration_in_minutes, :integer
  end
end
