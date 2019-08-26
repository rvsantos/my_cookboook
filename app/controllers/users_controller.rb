class UsersController < ApplicationController

  def my_recipes
    @recipes = current_user.recipes
  end

  def my_recipe_list
    @recipe_lists = current_user.recipe_lists
  end
end