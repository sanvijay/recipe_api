class CreateFeedbacks < ActiveRecord::Migration[6.1]
  def change
    create_table :feedbacks do |t|
      t.string :type
      t.string :description

      t.timestamps
    end
  end
end
