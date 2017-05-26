require "rails_helper"

feature "view ingredients" do
  let!(:category){ FactoryGirl.create(:category, name: "Fermentables") }
  let!(:ingredient){ FactoryGirl.create(:ingredient, category: category) }

  scenario "user visits ingredients index" do
    visit ingredients_path()

    expect(page).to have_content(ingredient.name)
  end

  scenario "user visits ingredient detail page" do
    visit ingredient_path(ingredient)

    expect(page).to have_content(ingredient.name)
    expect(page).to have_content(ingredient.category.name)
  end
end
