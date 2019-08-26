class AddRecipeRefAndRecipeListRefToRecipeListItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :recipe_list_items, :recipe, foreign_key: true
    add_reference :recipe_list_items, :recipe_list, foreign_key: true
  end
end
