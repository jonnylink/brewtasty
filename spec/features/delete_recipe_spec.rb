require "rails_helper"

feature "delete recipe" do
  let!(:user){ FactoryGirl.create(:user) }
  let!(:beer){ FactoryGirl.create(:recipe, user: user) }

  scenario "authenticated user can delete owned recipe" do
    sign_in_as user
    visit recipe_path(beer)
    click_link "delete recipe"
    expect(page).to have_content("#{beer.name} was deleted.")

    visit "/"
    expect(page).to_not have_content(beer.name)
  end

  scenario "authenticated user cannot delete unowned recipe" do
    some_lady = FactoryGirl.create(:user)

    sign_in_as some_lady
    visit recipe_path(beer)
    expect(page).to_not have_link("delete recipe")
  end

  scenario "unauthenticated user cannot delete recipe" do
    visit recipe_path(beer)
    expect(page).to_not have_link("delete recipe")
  end

  scenario "link hacking doesn't work" do
    visit "recipes/#{beer.id}/remove"
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

end
