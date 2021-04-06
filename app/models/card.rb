class Card < ApplicationRecord
  belongs_to :user
  has_many :protocols
  has_one_attached :image
end
