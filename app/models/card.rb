class Card < ApplicationRecord
  belongs_to :user
  has_many :protocols, dependent: :destroy
  has_one_attached :image

  validates :full_name, :birthday, presence: true
end
