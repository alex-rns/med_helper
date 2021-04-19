class Card < ApplicationRecord
  belongs_to :user
  has_many :protocols
  has_one_attached :image

  validates :full_name, :birthday, presence: true
end
