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
  validates :title, presence: true
  validates :description, presence: true
  validates :image_url, presence: true
  validates :author_id, presence: true
  validates :slug, presence: true, uniqueness: true

  validate :valid_ingredient_details
  validate :valid_instructions

  belongs_to :author, class_name: "User"

  has_many :favorites, dependent: :destroy
  has_many :liked_users, through: :favorites, class_name: "User", source: :user

  before_validation :create_slug
  before_save :store_ingredient_array

  private

  def create_slug
    self.slug = title&.parameterize unless slug
  end

  def valid_ingredient_details
    invalid = ingredient_details.any? do |ing|
      ing["unit"].blank? || ing["title"].blank? || ing["quantity"].blank?
    end

    errors.add(:ingredient_details, "one or more ingredient details are invalid") if invalid
  end

  def valid_instructions
    invalid = instructions.any? do |ing|
      ing["unit"].blank? || ing["order"].blank? || ing["value"].blank? || ing["duration"].blank?
    end

    errors.add(:instructions, "one or more instructions are invalid") if invalid
  end

  def store_ingredient_array
    self.ingredients = ingredient_details.map { |ing| ing['title'].downcase }
  end
end
