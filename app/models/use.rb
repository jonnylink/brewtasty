class Use < ApplicationRecord
  has_many :ingredients

  validates :name, presence: true
end
