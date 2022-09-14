class Post < ApplicationRecord
  validates :content, presence: true

  scope :default_order, -> { order(id: :desc) }
end
