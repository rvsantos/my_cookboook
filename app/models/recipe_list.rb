class RecipeList < ApplicationRecord
  belongs_to :user

  has_many :recipe_list_item
  has_many :recipes, through: :recipe_list_item

  validates :name, presence: true
  validates :name, uniqueness: true
end
