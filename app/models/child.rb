# frozen_string_literal: true

class Child < ApplicationRecord
  belongs_to :user
  has_one :vaccine, dependent: :destroy

  validates :name, :birthday, presence: true
end
