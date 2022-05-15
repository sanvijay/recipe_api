class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.string :slug
      t.string :title
      t.text :description
      t.string :image_url
      t.bigint :author_id

      t.timestamps
    end
  end
end
