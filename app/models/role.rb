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
  # @type [Role]
  DEVELOPER = Role.find_or_create_by(name: 'developer')

  # @type [Role]
  ADMIN = Role.find_or_create_by(name: 'admin')

  has_many :permissions, as: :holder

  has_many :role_assignments
  has_many :users, through: :role_assignments, dependent: :destroy
end
