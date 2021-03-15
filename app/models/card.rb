class Card < ApplicationRecord
  belongs_to :user
  belongs_to :expert
  delegate :visits, to: :user
end
