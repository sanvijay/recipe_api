# == Schema Information
#
# Table name: recipes
#
#  id                  :integer          not null, primary key
#  slug                :string
#  title               :string
#  description         :text
#  image_url           :string
#  author_id           :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  duration_in_minutes :integer
#  instructions        :jsonb
#  ingredients         :string           default("{}"), is an Array
#  ingredient_details  :jsonb
#

class Recipe < ApplicationRecord
	before_validation :create_slug

  belongs_to :author, class_name: "User"

  has_many :favorites
  has_many :liked_users, through: :favorites, class_name: "User", source: :user

	private

  def create_slug
    self.slug = title&.parameterize unless slug
  end
end
