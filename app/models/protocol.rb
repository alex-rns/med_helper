class Protocol < ApplicationRecord
  belongs_to :card
  enum type_of_inspection: { first_visit: 0, second_visit: 1}
  belongs_to :expert
end
