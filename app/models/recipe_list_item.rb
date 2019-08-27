class RecipeListItem < ApplicationRecord
  belongs_to :recipe
  belongs_to :recipe_list

  # validates :recipe, uniqueness: { message: 'Receita já adicionada!' }
end
