class User < ApplicationRecord
  devise :confirmable, :database_authenticatable, :recoverable, :registerable, :rememberable, :validatable

  validates :name, presence: true
  validates :username, presence: true, uniqueness: { case_sensitive: false }
end
