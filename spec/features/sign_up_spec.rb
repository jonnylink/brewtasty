require "rails_helper"

feature "user signs up" do
   scenario "specifies valid form information" do
     visit root_path
     click_link 'account'
     click_link 'sign_up'

     fill_in 'username', with: 'SomeGuy'
     fill_in 'email', with: 'my@email.com'
     fill_in 'password', with: 'testtest'
     fill_in 'password_confirmation', with: 'testtest'
     click_button 'sign up'

     expect(page).to have_content("SomeGuy")
     expect(page).to have_content("You're in!")
   end

   scenario "does not specify email" do
     visit root_path
     click_link 'account'
     click_link 'sign_up'

     fill_in 'username', with: 'SomeGuy'
     fill_in 'password', with: 'testtest'
     fill_in 'password_confirmation', with: 'testtest'
     click_button 'sign up'

     expect(page).to have_content("Sign up")
     expect(page).to have_content("Email can't be blank")
   end

   scenario "does not specify username" do
     visit root_path
     click_link 'account'
     click_link 'sign_up'

     fill_in 'email', with: 'my@email.com'
     fill_in 'password', with: 'testtest'
     fill_in 'password_confirmation', with: 'testtest'
     click_button 'sign up'

     expect(page).to have_content("Sign up")
     expect(page).to have_content("Username can't be blank")
   end

   scenario "specifies mismatched password" do
     visit root_path
     click_link 'account'
     click_link 'sign_up'

     fill_in 'username', with: 'SomeGuy'
     fill_in 'email', with: 'my@email.com'
     fill_in 'password', with: 'testtest'
     fill_in 'password_confirmation', with: 'testtess'
     click_button 'sign up'

     expect(page).to have_content("Sign up")
     expect(page).to have_content("doesn't match")
   end

   pending "prospective user can Sign up using google account"
end
