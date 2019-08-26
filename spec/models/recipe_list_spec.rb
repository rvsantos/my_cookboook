require 'rails_helper'

RSpec.describe RecipeList, type: :model do
  describe 'recipe belongs to list' do
    it 'list can have many recipes' do
      user = create(:user)
      cuisine = create(:cuisine)
      recipe_type = create(:recipe_type)
      other_user = create(:user, email: 'email2@email.com', password: '123456')
      other_cuisine = create(:cuisine, name: 'Finlandesa')
      other_recipe_type = create(:recipe_type, name: 'Prato Principal')
      recipe = create(:recipe, user: user, cuisine: cuisine,
                      recipe_type: recipe_type)
      other_recipe = create(:recipe, user: other_user, cuisine: other_cuisine,
                      recipe_type: other_recipe_type)

      list = RecipeList.create(name: 'Churrasco dos amigos', user: user)
      RecipeListItem.create(recipe: recipe, recipe_list: list)
      RecipeListItem.create(recipe: other_recipe, recipe_list: list)

      expect(list.recipes).to include recipe
      expect(list.recipes).to include other_recipe
    end
  end
end
