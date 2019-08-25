FactoryBot.define do
  factory :recipe do
    title { 'Bolo de Chocolate' }
    difficulty { 'Dificil' }
    ingredients { 'bolo de caixina do supermercado' }
    cook_time { 15 }
    cook_method { 'Misturar com agua e assar' }
    cuisine
    recipe_type
    user
  end
end