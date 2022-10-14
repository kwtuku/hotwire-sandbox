class Post < ApplicationRecord
  has_ancestry counter_cache: true

  validates :content, presence: true

  scope :default_order, -> { order(id: :desc) }
end
