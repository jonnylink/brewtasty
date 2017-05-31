require "rails_helper"

feature "view ingredients" do
  let!(:fermentables){ FactoryGirl.create(:category, name: "Fermentables") }
  let!(:yeasts){ FactoryGirl.create(:category, name: "Yeasts") }
  let!(:hops){ FactoryGirl.create(:category, name: "Hops") }
  let!(:others){ FactoryGirl.create(:category, name: "Others") }
  let!(:ingredient1){ FactoryGirl.create(:ingredient, category: fermentables) }
  let!(:ingredient2){ FactoryGirl.create(:ingredient, category: yeasts) }
  let!(:ingredient3){ FactoryGirl.create(:ingredient, category: hops, alpha: 4.5) }
  let!(:ingredient4){ FactoryGirl.create(:ingredient, category: others) }

  scenario "user visits ingredients index" do
    visit ingredients_path()
    expect(page).to have_content(ingredient1.name)

    click_link yeasts.name
    expect(page).to have_content(ingredient2.name)

    click_link hops.name
    expect(page).to have_content(ingredient3.name)

    click_link others.name
    expect(page).to have_content(ingredient4.name)
  end

  scenario "user visits ingredient detail page" do
    visit ingredient_path(ingredient1)

    expect(page).to have_content(ingredient1.name)
    expect(page).to have_content(ingredient1.category.name)
  end
end
