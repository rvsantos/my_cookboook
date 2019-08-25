class RecipeType < ApplicationRecord
  has_many :recipes

  validates :name, presence: true
  validates :name, uniqueness: { message: 'Tipo de receita já cadastrado' }
end
