# frozen_string_literal: true

# == Schema Information
#
# Table name: role_assignments
#
# @!attribute id
#   @return []
# @!attribute created_at
#   @return [Time]
# @!attribute updated_at
#   @return [Time]
# @!attribute role_id
#   @return []
# @!attribute user_id
#   @return []
#
class RoleAssignment < ApplicationRecord
  belongs_to :user
  belongs_to :role
end
