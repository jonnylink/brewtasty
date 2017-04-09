require "rails_helper"

feature "create rating" do

  scenario "authenticated user can rate unowned recipe" do
    user = FactoryGirl.create(:user)
    some_guy = FactoryGirl.create(:user)
    beer = FactoryGirl.create(:recipe, user: user)

    sign_in_as some_guy
    visit recipe_path(beer)
    page.choose("rating_rating_nice")
    click_button "submit"

    expect(page).to have_content("Thanks for your rating!")
    expect(page).to have_content("nice")
    expect(page).to have_content(some_guy.username)
  end

  scenario "authenticated user can leave comments" do
    user = FactoryGirl.create(:user)
    some_guy = FactoryGirl.create(:user)
    beer = FactoryGirl.create(:recipe, user: user)

    sign_in_as some_guy
    visit recipe_path(beer)
    page.choose("rating_rating_gross")
    fill_in "rating_comment", with: "I hated it!!!!!"
    click_button "submit"

    expect(page).to have_content("Thanks for your rating!")
    expect(page).to have_content(some_guy.username)
    expect(page).to have_content("I hated it!!!!!")
    expect(page).to have_content("gross")
  end

  scenario "authenticated user cannot rate owned recipe" do
    user = FactoryGirl.create(:user)
    beer = FactoryGirl.create(:recipe, user: user)
    sign_in_as user
    visit recipe_path(beer)
    expect(page).to have_content("Sorry, you cannot rate your own recipe.")
  end

  scenario "unauthenticated user cannot rate recipe" do
    user = FactoryGirl.create(:user)
    beer = FactoryGirl.create(:recipe, user: user)
    visit recipe_path(beer)
    expect(page).to have_content("sign in to rate this beer recipe.")
  end

  scenario "rating can't be blank" do
    user = FactoryGirl.create(:user)
    beer = FactoryGirl.create(:recipe, user: user)
    some_guy = FactoryGirl.create(:user)
    sign_in_as some_guy
    visit recipe_path(beer)
    click_button "submit"
    expect(page).to have_content("Rating can't be blank")
  end
end
