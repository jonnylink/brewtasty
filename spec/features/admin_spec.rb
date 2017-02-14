require "rails_helper"

feature "admin management" do

  scenario "admin can delete any rating" do
    user = FactoryGirl.create(:user)
    beer = FactoryGirl.create(:recipe, user: user)
    angry_fella = FactoryGirl.create(:user)
    comment = FactoryGirl.create(:rating, recipe: beer, user: angry_fella)
    admin = FactoryGirl.create(:user, admin: true)

    sign_in_as admin
    visit recipe_path(beer)
    expect(page).to have_link("delete_rating_#{angry_fella.id}")
    click_link "delete_rating_#{angry_fella.id}"
    expect(page).to have_content("Rating deleted.")
  end

  scenario "admin can delete any recipe" do
    user = FactoryGirl.create(:user)
    beer = FactoryGirl.create(:recipe, user: user)
    admin = FactoryGirl.create(:user, admin: true)

    sign_in_as admin
    visit recipe_path(beer)
    click_link "delete recipe"
    expect(page).to have_content("#{beer.name} was deleted.")      
  end

  pending "admin can ban basic users"
  pending "admin cannot ban admins"
  pending "admin can unban basic users"

end
