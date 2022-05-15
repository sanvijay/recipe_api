# == Schema Information
#
# Table name: favorites
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  recipe_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_favorites_on_recipe_id              (recipe_id)
#  index_favorites_on_user_id                (user_id)
#  index_favorites_on_user_id_and_recipe_id  (user_id,recipe_id) UNIQUE
#

class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
end
