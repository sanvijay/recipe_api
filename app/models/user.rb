# frozen_string_literal: true
# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string
#  last_name              :string
#  accepted_guidelines    :boolean          default("false")
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  failed_attempts        :integer          default("0"), not null
#  unlock_token           :string
#  locked_at              :datetime
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

# require 'password_complexity_validator'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable, :lockable, :validatable
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false }
  validates :first_name, :last_name, presence: true

  # validates_with PasswordComplexityValidator, if: :password
  validates :password, confirmation: true
  validates :password_confirmation,
            presence: true,
            if: :password
  has_one :access_token, -> { order 'created_at DESC' },
          class_name: 'Doorkeeper::AccessToken',
          foreign_key: :resource_owner_id,
          dependent: :destroy,
          inverse_of: false

  has_many :created_recipes, foreign_key: :author_id, class_name: "Recipe"

  has_many :favorites
  has_many :favorite_recipes, through: :favorites, class_name: "Recipe", source: :recipe

  def logged_in_with_invalid_password
    increment_failed_attempts
    if attempts_exceeded?
      lock_access! unless access_locked?
    else
      save(validate: false)
    end
  end

  def self.find_by_case_insensitive_email(email)
    where('lower(email) = lower(?)', email.downcase).first
  end
end
