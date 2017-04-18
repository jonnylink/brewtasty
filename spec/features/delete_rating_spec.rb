require "rails_helper"

feature "delete rating" do
  let!(:user){ FactoryGirl.create(:user) }
  let!(:beer){ FactoryGirl.create(:recipe, user: user) }
  let!(:angry_fella){ FactoryGirl.create(:user) }
  let!(:comment){ FactoryGirl.create(:rating, recipe: beer, user: angry_fella) }

  scenario "authenticated user can delete owned rating" do
    sign_in_as angry_fella
    visit recipe_path(beer)
    click_link "delete_rating_#{angry_fella.id}"

    expect(page).to_not have_content(comment.comment)
  end

  scenario "authenticated user cannot delete unowned rating" do
    sign_in_as user
    visit recipe_path(beer)

    expect(page).to_not have_link("delete_rating_#{angry_fella.id}")
  end

  scenario "unauthenticated user cannot delete rating" do
    visit recipe_path(beer)

    expect(page).to_not have_link("delete_rating_#{angry_fella.id}")
  end

end
