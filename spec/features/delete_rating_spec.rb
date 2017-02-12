require "rails_helper"

feature "delete rating" do

  scenario "authenticated user can delete owned rating" do
    user = FactoryGirl.create(:user)
    beer = FactoryGirl.create(:recipe, user: user)
    angry_fella = FactoryGirl.create(:user)
    comment = FactoryGirl.create(:rating, recipe: beer, user: angry_fella)
    sign_in_as angry_fella
    visit recipe_path(beer)
    click_link "delete_rating_#{angry_fella.id}"

    expect(page).to_not have_content(comment.comment)
  end

  scenario "authenticated user cannot delete unowned rating" do
    user = FactoryGirl.create(:user)
    beer = FactoryGirl.create(:recipe, user: user)
    angry_fella = FactoryGirl.create(:user)
    comment = FactoryGirl.create(:rating, recipe: beer, user: angry_fella)
    sign_in_as user
    visit recipe_path(beer)

    expect(page).to_not have_link("delete_rating_#{angry_fella.id}")
  end

  scenario "unauthenticated user cannot delete rating" do
    user = FactoryGirl.create(:user)
    beer = FactoryGirl.create(:recipe, user: user)
    angry_fella = FactoryGirl.create(:user)
    comment = FactoryGirl.create(:rating, recipe: beer, user: angry_fella)
    visit recipe_path(beer)

    expect(page).to_not have_link("delete_rating_#{angry_fella.id}")
  end

end
