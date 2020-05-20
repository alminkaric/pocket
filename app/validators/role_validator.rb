# typed: strict
# frozen_string_literal: true

class RoleValidator < Role
  include IValidator

  validates :name, presence: true, uniqueness: true
end
