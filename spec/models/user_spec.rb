require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#is_owner?' do
    it 'true' do
      recipe_type = create(:recipe_type)
      cuisine = create(:cuisine)
      user = create(:user)
      recipe = create(:recipe, cuisine: cuisine, user: user,
                      recipe_type: recipe_type)

      result = user.is_owner?(recipe)

      expect(result).to eq true
    end

    it 'false' do
      recipe_type = create(:recipe_type)
      cuisine = create(:cuisine)
      user = create(:user)
      other_user = create(:user, email: 'email2@email.com', password: '123456')
      recipe = create(:recipe, cuisine: cuisine, user: user,
                      recipe_type: recipe_type)

      result = other_user.is_owner?(recipe)

      expect(result).to be_falsey
    end
  end
end
