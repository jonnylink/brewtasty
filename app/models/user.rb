class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :ratings
  has_many :recipes

  validates :username, presence: true
  validates :email, uniqueness: true, presence: true

  def active_for_authentication?
    super && active == 1
  end

  def inactive_message
    active == 1 ? super : :locked
  end
end
