# frozen_string_literal: true

# == Schema Information
#
# Table name: people
#
# @!attribute id
#   @return []
# @!attribute first_name
#   @return [String]
# @!attribute last_name
#   @return [String]
# @!attribute created_at
#   @return [Time]
# @!attribute updated_at
#   @return [Time]
# @!attribute client_id
#   @return []
# @!attribute employee_id
#   @return [String]
# @!attribute user_id
#   @return []
#
class Person < ApplicationRecord
  belongs_to :client

  # @!method user
  #   @return [User]
  belongs_to :user
end
