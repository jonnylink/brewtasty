require "rails_helper"

feature "user signs in" do
  scenario "specifies valid email and password" do
    user = FactoryGirl.create(:user)
    sign_in_as user

    expect(page).to have_content("Welcome back")
    expect(page).to have_content("sign out")
  end

  scenario "specifies invalid email" do
    user = FactoryGirl.create(:user)
    visit root_path

    click_link "sign_in"
    fill_in "email", with: "blah@email.con"
    fill_in "password", with: user.password
    click_button "sign in"

    expect(page).to have_content("Invalid Email or password")
    expect(page).to have_content("sign in")
  end

  scenario "specifies invalid password" do
    user = FactoryGirl.create(:user)
    visit root_path

    click_link "sign_in"
    fill_in "email", with: user.email
    fill_in "password", with: "bob"
    click_button "sign in"

    expect(page).to have_content("Invalid Email or password")
    expect(page).to have_content("sign in")
  end
end

feature "user signs out" do
  scenario "signs out" do
    user = FactoryGirl.create(:user)
    sign_in_as user
    click_link "sign out"

    expect(page).to have_content("Adios!")
    expect(page).to have_content("sign in")
  end
end
