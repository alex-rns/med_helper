class Event < ApplicationRecord
  belongs_to :expert
  belongs_to :user
  validates :name, :phone, :email, :time, :comment, presence: true
  validates :comment, length: { maximum: 256 }

end
