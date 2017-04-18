require "rails_helper"

feature "user edits account" do
  let!(:user){ FactoryGirl.create(:user) }


  scenario "specifies new email" do
    sign_in_as user

    click_link "user_accnt"
    fill_in "email", with: "new@email.org"
    fill_in "user_current_password", with: user.password
    click_button "update"

    expect(page).to have_content("Account successfully updated.")
    click_link "user_accnt"
    expect(page).to have_selector("input[value='new@email.org']")
  end

  scenario "specifies new password" do
    sign_in_as user
    old_password = user.password
    user.password = "my_new_password"

    click_link "user_accnt"
    fill_in "user_password", with: user.password
    fill_in "user_password_confirmation", with: user.password
    fill_in "user_current_password", with: old_password
    click_button "update"
    expect(page).to have_content("Account successfully updated.")

    click_link "sign out"
    sign_in_as user
    expect(page).to have_content("Welcome back")
  end

  scenario "specifies new name" do
    sign_in_as user

    click_link "user_accnt"
    fill_in "username", with: "Billy Boy"
    fill_in "user_current_password", with: user.password
    click_button "update"
    expect(page).to have_content("Account successfully updated.")

    click_link "user_accnt"
    expect(page).to have_selector("input[value='Billy Boy']")
  end

  scenario "deletes account" do
    sign_in_as user

    click_link "user_accnt"
    click_button "delete my account"
    expect(page).to have_content("Sorry to see you go. We'll be here if you want to come back.")

    sign_in_as user
    expect(page).to have_content("Invalid Email or password.")
  end
end
