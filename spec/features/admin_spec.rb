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

  scenario "admin can ban basic users" do
    user = FactoryGirl.create(:user)
    admin = FactoryGirl.create(:user, admin: true)

    sign_in_as admin
    visit 'admin/users'
    expect(page).to have_content(user.username)

    click_link "ban_user_#{user.id}"
    expect(page).to have_content("#{user.username} was banned.")

    click_link "sign out"
    sign_in_as user
    expect(page).to have_content("Your account is locked.")
  end

  scenario "admin cannot ban admins" do
    other_admin = FactoryGirl.create(:user, admin: true)
    admin = FactoryGirl.create(:user, admin: true)

    sign_in_as admin
    visit 'admin/users'
    expect(page).to_not have_link("ban_user_#{other_admin.id}")
  end

  scenario "admin can unban basic users" do
    banned_user = FactoryGirl.create(:user, active: 2)
    admin = FactoryGirl.create(:user, admin: true)

    sign_in_as admin
    visit 'admin/users'
    expect(page).to have_content(banned_user.username)

    click_link "unban_user_#{banned_user.id}"
    expect(page).to have_content("#{banned_user.username} was unbanned.")

    click_link "sign out"
    sign_in_as banned_user
    expect(page).to have_content("Welcome back")
  end

end
