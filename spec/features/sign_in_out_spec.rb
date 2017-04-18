require "rails_helper"

feature "user signs in" do
  let!(:user){ FactoryGirl.create(:user) }

  scenario "specifies valid email and password" do
    sign_in_as user

    expect(page).to have_content("Welcome back")
    expect(page).to have_content(user.username)
  end

  scenario "specifies invalid email" do
    visit root_path

    click_link "sign_in"
    fill_in "email", with: "blah@email.con"
    fill_in "password", with: user.password
    click_button "sign in"

    expect(page).to have_content("Invalid Email or password")
    expect(page).to have_link("account")
    expect(page).to have_selector(:css, "#sign_up")
  end

  scenario "specifies invalid password" do
    visit root_path

    click_link "sign_in"
    fill_in "email", with: user.email
    fill_in "password", with: "bob"
    click_button "sign in"

    expect(page).to have_content("Invalid Email or password")
    expect(page).to have_link("account")
    expect(page).to have_selector(:css, "#sign_up")
  end
end

feature "user signs out" do
  let!(:user){ FactoryGirl.create(:user) }

  scenario "signs out" do
    sign_in_as user
    click_link "sign out"

    expect(page).to have_content("Adios!")
    expect(page).to have_link("account")
  end
end
