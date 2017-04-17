require 'spec_helper'

describe Rating do
  it "has a valid factory" do
    maker = FactoryGirl.create(:user)
    rater = FactoryGirl.create(:user)
    recipe = FactoryGirl.create(:recipe, user: maker)
    expect(FactoryGirl.create(:rating, recipe: recipe, user: rater)).to be_valid
  end

  it {expect validate_presence_of(:user_id)}
  it {expect validate_presence_of(:recipe_id)}
  it {expect validate_presence_of(:rating)}

  describe 'rating_description' do
    context 'have a number rating' do
      it 'zero returns unrated' do
        expect(Rating.rating_description(0)).to eq('unrated')
      end
      it 'one returns gross!' do
        expect(Rating.rating_description(1)).to eq('gross!')
      end
      it 'two returns meh...' do
        expect(Rating.rating_description(2)).to eq('meh...')
      end
      it 'three returns nice.' do
        expect(Rating.rating_description(3)).to eq('nice.')
      end
      it 'four returns omg!' do
        expect(Rating.rating_description(4)).to eq('omg!')
      end
      it 'other numbers return error' do
        expect(Rating.rating_description(32)).to eq('error?!')
      end
      it 'other numbers return error' do
        expect(Rating.rating_description(-21)).to eq('error?!')
      end
    end

    describe 'rating_array_index' do
      context 'have a text rating' do
        it 'gross! returns 1' do
          expect(Rating.rating_array_index('gross!')).to eq(1)
        end
        it 'meh... returns 2' do
          expect(Rating.rating_array_index('meh...')).to eq(2)
        end
        it 'nice. returns 3' do
          expect(Rating.rating_array_index('nice.')).to eq(3)
        end
        it 'omg! returns 4' do
          expect(Rating.rating_array_index('omg!')).to eq(4)
        end
      end
    end
  end

end
