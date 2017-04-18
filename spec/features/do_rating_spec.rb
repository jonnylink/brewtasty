require "rails_helper"

feature "rate beer recipes" do
  let!(:user){ FactoryGirl.create(:user) }
  let!(:some_guy){ FactoryGirl.create(:user) }
  let!(:beer){ FactoryGirl.create(:recipe, user: user) }

  scenario "authenticated user can rate unowned recipe" do
    sign_in_as some_guy
    visit recipe_path(beer)
    page.choose("rating_rating_nice")
    click_button "submit"

    expect(page).to have_content("Thanks for your rating!")
    expect(page).to have_content("nice")
    expect(page).to have_content(some_guy.username)
  end

  scenario "authenticated user can leave comments" do
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
    sign_in_as user
    visit recipe_path(beer)
    expect(page).to have_content("Sorry, you cannot rate your own recipe.")
  end

  scenario "unauthenticated user cannot rate recipe" do
    visit recipe_path(beer)
    expect(page).to have_content("sign in to rate this beer recipe.")
  end

  scenario "rating can't be blank" do
    sign_in_as some_guy
    visit recipe_path(beer)
    click_button "submit"
    expect(page).to have_content("Rating can't be blank")
  end

  scenario "re-rate a recipe" do
    sign_in_as some_guy
    visit recipe_path(beer)
    page.choose("rating_rating_gross")
    fill_in "rating_comment", with: "I hated it!!!!!"
    click_button "submit"

    expect(page).to have_content("Thanks for your rating!")
    expect(page).to have_content(some_guy.username)
    expect(page).to have_content("I hated it!!!!!")
    expect(page).to have_content("gross")

    page.choose("rating_rating_omg")
    fill_in "rating_comment", with: "No, wait, I love it!"
    click_button "submit"

    expect(page).to have_content("No, wait, I love it!")
    expect(page).to have_content("omg")
  end

  scenario "re-rate a recipe with invalid info" do
    sign_in_as some_guy
    visit recipe_path(beer)
    page.choose("rating_rating_gross")
    fill_in "rating_comment", with: "I hated it!!!!!"
    click_button "submit"

    expect(page).to have_content("Thanks for your rating!")
    expect(page).to have_content(some_guy.username)
    expect(page).to have_content("I hated it!!!!!")
    expect(page).to have_content("gross")

    click_button "submit"

    expect(page).to have_content("Rating can't be blank")
  end

end
