require "rails_helper"

feature "update recipe" do
  scenario "authenticated user can edit user created recipe" do
    user = FactoryGirl.create(:user)
    beer = FactoryGirl.create(:recipe, user: user)

    sign_in_as user
    visit edit_recipe_path(beer)

    fill_in "recipe_name", with: "neat-o beer"
    fill_in "recipe_notes", with: "some notes"
    fill_in "recipe_batch_size", with: 5
    fill_in "recipe_boil_size", with: 6
    fill_in "recipe_boil_time", with: 90
    fill_in "recipe_original_gravity", with: 9.9
    fill_in "recipe_final_gravity", with: 8.0
    fill_in "recipe_alcohol_by_volume", with: 7.6
    fill_in "recipe_bitterness", with: 3.5
    fill_in "recipe_color", with: 12.2
    fill_in "recipe_keg_temp", with: 52
    fill_in "recipe_storage_temp", with: 50
    fill_in "recipe_age_for", with: 23
    click_button "update Recipe"

    expect(page).to have_content("was updated!")
    expect(page).to have_content("neat-o beer")
  end

  scenario "authenticated user can edit user created recipe" do
    user = FactoryGirl.create(:user)
    beer = FactoryGirl.create(:recipe, user: user)

    sign_in_as user
    visit edit_recipe_path(beer)

    fill_in "recipe_name", with: ""
    fill_in "recipe_notes", with: ""
    click_button "update Recipe"

    expect(page).to have_content("Recipe not updated! Name can't be blank")
  end

  scenario "authenticated user cannot edit other user's recipe" do
    user = FactoryGirl.create(:user)
    beer = FactoryGirl.create(:recipe, user: user)
    some_guy = FactoryGirl.create(:user)

    sign_in_as some_guy
    visit edit_recipe_path(beer)
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

  scenario "unauthenticated user cannot edit recipe" do
    user = FactoryGirl.create(:user)
    beer = FactoryGirl.create(:recipe, user: user)

    visit edit_recipe_path(beer)
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

end
