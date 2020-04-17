class Client < ApplicationRecord
  has_many :people
  enum status: { active: 0, inactive: 1 }
end
