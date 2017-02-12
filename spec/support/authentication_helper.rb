module AuthenticationHelper
  def sign_in_as(user)
    visit "/"
    click_link "sign_in"
    fill_in "email", with: user.email
    fill_in "password", with: user.password
    click_button "sign in"
  end
end
