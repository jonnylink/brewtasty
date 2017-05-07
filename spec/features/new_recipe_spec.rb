require "rails_helper"

feature "Add recipe" do
  let!(:user){ FactoryGirl.create(:user) }

  scenario "authenticated user adds recipe" do
    sign_in_as user

    click_link "add recipe"
    fill_in "recipe_name", with: "neat-o beer"
    fill_in "recipe_notes", with: "some notes"
    fill_in "recipe_batch_size", with: 5.5
    fill_in "recipe_boil_size", with: 6
    fill_in "recipe_boil_time", with: 90
    fill_in "recipe_boil_gravity", with: 1.06
    fill_in "recipe_original_gravity", with: 1.08
    fill_in "recipe_final_gravity", with: 1.05
    fill_in "recipe_ferment_temp", with: 62
    click_button "add Recipe"

    expect(page).to have_content("Recipe started!")
    expect(page).to have_content("neat-o beer")
  end

  scenario "authenticated user adds ingredients to owned recipe" do
    factory_category = FactoryGirl.create(:category)
    factory_ingredient = FactoryGirl.create(:ingredient, category: factory_category)
    factory_unit = FactoryGirl.create(:unit)
    factory_beer = FactoryGirl.create(:recipe, user: user)

    sign_in_as user
    visit recipe_path(factory_beer)

    click_link "add ingredient"
    fill_in "recipe_ingredient_amount", with: 25
    click_button "add Recipe ingredient"

    expect(page).to have_content("Ingredient added!")
  end

  scenario "authenticated user adds invalid ingredients to owned recipe" do
    factory_category = FactoryGirl.create(:category)
    factory_ingredient = FactoryGirl.create(:ingredient, category: factory_category)
    factory_unit = FactoryGirl.create(:unit)
    factory_beer = FactoryGirl.create(:recipe, user: user)

    sign_in_as user
    visit recipe_path(factory_beer)

    click_link "add ingredient"
    click_button "add Recipe ingredient"

    expect(page).to have_content("Ingredient not added.")
    expect(page).to have_content("Amount is not a number")
  end

  scenario "recipe name required" do
    sign_in_as user

    click_link "add recipe"
    fill_in "recipe_notes", with: "some notes"
    fill_in "recipe_batch_size", with: 5
    fill_in "recipe_boil_size", with: 6
    fill_in "recipe_boil_time", with: 90
    fill_in "recipe_boil_gravity", with: 1.08
    fill_in "recipe_original_gravity", with: 1.09
    fill_in "recipe_final_gravity", with: 1.06
    click_button "add Recipe"

    expect(page).to have_content("Recipe not added.")
    expect(page).to have_content("Name can't be blank")
  end

  scenario "recipe name must be unique" do
    Recipe.create(user_id: user.id, name: "neat-o beer")
    sign_in_as user

    click_link "add recipe"
    fill_in "recipe_name", with: "neat-o beer"
    click_button "add Recipe"

    expect(page).to have_content("Recipe not added")
    expect(page).to have_content("Name has already been taken")
  end

  scenario "unauthenticated user cannot add recipe" do
    visit root_path
    expect(page).to_not have_content("add recipe")
  end

  ########## to be added later #################
  pending "no ingredients"
  pending "recipe already added" #based on ingredients and amounts
end
