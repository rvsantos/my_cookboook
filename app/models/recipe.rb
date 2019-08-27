class Recipe < ApplicationRecord
  validates :title, :recipe_type, :cuisine, :difficulty, :cook_time,
            :ingredients, :cook_method, presence: true

  belongs_to :recipe_type
  belongs_to :user
  belongs_to :cuisine

  has_many :recipe_list_item
  has_many :recipe_list, through: :recipe_list_item

  enum status: { pending: 0, published: 10, reviewed: 20 }

  def cook_time_min
    "#{cook_time} minutos"
  end
end
