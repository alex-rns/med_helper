class Event < ApplicationRecord
  belongs_to :expert
  belongs_to :user
  validates :name, :phone, :email, :start_time, :end_time, :comment, presence: true
  validates :comment, length: { maximum: 256 }
  enum type: { offline: 0, online: 1}
end
