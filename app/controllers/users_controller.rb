class UsersController < ApplicationController
  def my_recipes
    @recipes = current_user.recipes
  end
end