class CreateIngredients < ActiveRecord::Migration[6.1]
  def change
    create_table :ingredients do |t|
      t.string :slug
      t.string :title
      t.string :image

      t.timestamps
    end
  end
end
