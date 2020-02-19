class Todo < ApplicationRecord
  has_many :item
  validates :title, presence: true
end
