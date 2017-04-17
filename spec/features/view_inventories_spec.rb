require "rails_helper"

feature "view inventories" do
  let!(:category) {FactoryGirl.create(:category)}
  let!(:ingredient) {FactoryGirl.create(:ingredient, category: category)}
  let!(:unit) {FactoryGirl.create(:unit)}
  let!(:user) {FactoryGirl.create(:user)}
  let!(:inventory) {FactoryGirl.create(:inventory,
    ingredient: ingredient,
    unit: unit,
    user: user
  )}

  scenario "signed in user visits index" do
    sign_in_as user
    visit inventories_path()

    expect(page).to have_content(inventory.ingredient.name)
    expect(page).to have_content(inventory.amount)
  end

  scenario "signed in user visits detail page" do
    sign_in_as user
    visit inventory_path(inventory)

    expect(page).to have_content(inventory.ingredient.name)
    expect(page).to have_content(inventory.amount)
  end

  scenario "non-signed in user visits index" do
    visit inventories_path()
    expect(page).to have_content("The page you were looking for doesn't exist")
  end

  scenario "signed in user visits detail page" do
    visit inventory_path(inventory)
    expect(page).to have_content("The page you were looking for doesn't exist")
  end

end
