# typed: strict
# frozen_string_literal: true

class Person < ApplicationRecord
  belongs_to :client

  # @!method user
  #   @return [User]
  belongs_to :user
end
