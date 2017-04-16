require "rails_helper"

feature "view ingredients" do
  scenario "user visits ingredients index" do
    category = FactoryGirl.create(:category)
    ingredient = FactoryGirl.create(:ingredient, category: category)
    visit ingredients_path()

    expect(page).to have_content(ingredient.name)
  end

  scenario "user visits ingredient detail page" do
    category = FactoryGirl.create(:category)
    ingredient = FactoryGirl.create(:ingredient, category: category)
    visit ingredient_path(ingredient)

    expect(page).to have_content(ingredient.name)
    expect(page).to have_content(ingredient.category.name)  
  end
end
