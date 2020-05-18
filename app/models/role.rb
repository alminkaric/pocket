# typed: strict
# frozen_string_literal: true

class Role < ApplicationRecord
  extend T::Sig
  has_many :permissions, as: :holder

  has_many :role_assignments
  has_many :users, through: :role_assignments, dependent: :destroy

  # @return [Role]
  sig { returns(Role) }
  def self.admin
    T.must(Role.find_by(name: 'Admin'))
  end
end
