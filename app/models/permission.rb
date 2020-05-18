# typed: strict
# frozen_string_literal: true

class Permission < ApplicationRecord
  # @!method holder
  belongs_to :holder, polymorphic: true
end
