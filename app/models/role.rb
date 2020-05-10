# frozen_string_literal: true

# == Schema Information
#
# Table name: roles
#
# @!attribute id
#   @return []
# @!attribute name
#   @return [String]
# @!attribute created_at
#   @return [Time]
# @!attribute updated_at
#   @return [Time]
#
class Role < ApplicationRecord
  has_many :permissions, as: :holder

  has_many :role_assignments
  has_many :users, through: :role_assignments, dependent: :destroy

  # @return [Role]
  def self.admin
    Role.find_by(name: 'Admin')
  end
end
