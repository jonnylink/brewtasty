require "rails_helper"

feature "Add recipe" do
  scenario "authenticated user adds recipe" do
    user = FactoryGirl.create(:user)
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

    expect(page).to have_content("Recipe added!")
    expect(page).to have_content("neat-o beer")
  end

  scenario "recipe name required" do
    user = FactoryGirl.create(:user)
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
    user = FactoryGirl.create(:user)
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
