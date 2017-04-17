require 'rails_helper'

feature "manage inventory" do
  let!(:category) {FactoryGirl.create(:category)}
  let!(:ingredient) {FactoryGirl.create(:ingredient, category: category)}
  let!(:unit) {FactoryGirl.create(:unit)}
  let!(:user) {FactoryGirl.create(:user)}
  let!(:inventory) {FactoryGirl.create(:inventory,
    ingredient: ingredient,
    unit: unit,
    user: user
  )}

  scenario "user adds new inventory" do
    sign_in_as user
    click_link "Inventory"
    click_link "add inventory"
    fill_in "inventory_amount", with: 4
    click_button "add Inventory"

    expect(page).to have_content("Inventory added!")
    expect(page).to have_content("4.0")
  end

  scenario "user adds new inventory without adding amount" do
    sign_in_as user
    visit new_inventory_path
    click_button "add Inventory"

    expect(page).to have_content("Inventory not added")
    expect(page).to have_content("Amount can't be blank")
  end

  scenario "user updates inventory" do
    sign_in_as user
    visit inventory_path(inventory)
    fill_in "inventory_amount", with: 9
    click_button "update Inventory"

    expect(page).to have_content("Your inventory was updated!")
    expect(page).to have_content("9.0")
  end

  scenario "user updates inventory with blank amount" do
    sign_in_as user
    visit inventory_path(inventory)
    fill_in "inventory_amount", with: ''
    click_button "update Inventory"

    expect(page).to have_content("Inventory not updated")
    expect(page).to have_content("Amount can't be blank")
  end

  scenario "user deletes inventory" do
    sign_in_as user
    visit inventory_path(inventory)
    click_link "delete_inventory"

    expect(page).to have_content("Inventory deleted")
  end

end
