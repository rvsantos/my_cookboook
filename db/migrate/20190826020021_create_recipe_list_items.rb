class CreateRecipeListItems < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_list_items do |t|

      t.timestamps
    end
  end
end
