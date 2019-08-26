class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :recipes

  has_many :recipe_lists
  has_many :recipe_list_item, through: :recipe_lists
  has_many :recipes_on_list, through: :recipe_list_item, source: :recipe

  def is_owner?(recipe)
    true if recipe.user == self
  end
end
