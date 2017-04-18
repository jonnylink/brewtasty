require "rails_helper"

feature "update recipe" do
  let!(:user){ FactoryGirl.create(:user) }
  let!(:beer){ FactoryGirl.create(:recipe, user: user) }


  scenario "authenticated user can edit user created recipe" do
    sign_in_as user
    visit edit_recipe_path(beer)

    fill_in "recipe_name", with: "neat-o beer"
    fill_in "recipe_notes", with: "some notes"
    fill_in "recipe_batch_size", with: 5
    fill_in "recipe_boil_size", with: 6
    fill_in "recipe_boil_time", with: 95
    fill_in "recipe_boil_gravity", with: 1.08
    fill_in "recipe_original_gravity", with: 1.09
    fill_in "recipe_final_gravity", with: 1.06
    click_button "update Recipe"

    expect(page).to have_content("was updated!")
    expect(page).to have_content("neat-o beer")
  end

  scenario "authenticated user can edit user created recipe" do
    sign_in_as user
    visit edit_recipe_path(beer)

    fill_in "recipe_name", with: ""
    fill_in "recipe_notes", with: ""
    click_button "update Recipe"

    expect(page).to have_content("Recipe not updated! Name can't be blank")
  end

  scenario "authenticated user cannot edit other user's recipe" do
    some_guy = FactoryGirl.create(:user)

    sign_in_as some_guy
    visit edit_recipe_path(beer)

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

  scenario "unauthenticated user cannot edit recipe" do
    visit edit_recipe_path(beer)

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

end
