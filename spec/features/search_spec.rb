require "rails_helper"

feature "recipe search" do

  scenario "displays a list of recipe results if found" do
    user = FactoryGirl.create(:user)
    beer = FactoryGirl.create(:recipe, user: user)
    visit '/'
    fill_in "search_recipes", with: "beer"
    click_button "search"
    expect(page).to have_content(beer.name)
  end

  scenario "displays a message if nothing found" do
    visit '/'
    fill_in "search_recipes", with: "beer"
    click_button "search"
    expect(page).to have_content("Sorry, no recipes found.")
  end

end
