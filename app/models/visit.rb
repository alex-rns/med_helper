class Visit < ApplicationRecord
  belongs_to :event
  enum type_of_inspection: { first_visit: 0, second_visit: 1}
end
