RATINGS = ["unrated", "gross!", "meh...", "nice.", "omg!", "error?!"]

class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  validates :user_id, presence: true
  validates :recipe_id, presence: true
  validates :rating, presence: true

  def self.rating_description(rating)
    if rating == 0
      RATINGS[0]
    elsif rating >= 3.8
      RATINGS[4]
    elsif rating >= 3
      RATINGS[3]
    elsif rating >= 2
      RATINGS[2]
    elsif rating >= 1
      RATINGS[1]
    else
      RATINGS[5]
    end
  end

  def self.rating_array_index(rating)
    RATINGS.find_index(rating)
  end
end
