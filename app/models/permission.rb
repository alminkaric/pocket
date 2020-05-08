# frozen_string_literal: true

# == Schema Information
#
# Table name: permissions
#
# @!attribute id
#   @return []
# @!attribute class_name
#   @return [String]
# @!attribute holder_type
#   @return [String]
# @!attribute method_name
#   @return [String]
# @!attribute created_at
#   @return [Time]
# @!attribute updated_at
#   @return [Time]
# @!attribute holder_id
#   @return []
#
class Permission < ApplicationRecord
  # @!method holder
  belongs_to :holder, polymorphic: true
end
