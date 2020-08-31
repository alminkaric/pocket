# typed: strict
# frozen_string_literal: true

class Person < ApplicationRecord
  belongs_to :client
  belongs_to :user
end
