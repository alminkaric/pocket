# frozen_string_literal: true

# == Schema Information
#
# Table name: clients
#
# @!attribute id
#   @return []
# @!attribute description
#   @return [String]
# @!attribute name
#   @return [String]
# @!attribute start_of_trial
#   @return [Date]
# @!attribute status
#   @return [Integer]
# @!attribute trial_days
#   @return [Integer]
# @!attribute created_at
#   @return [Time]
# @!attribute updated_at
#   @return [Time]
#
class Client < ApplicationRecord
  has_many :people
  enum status: { active: 0, inactive: 1 }
end
