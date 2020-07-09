# typed: strict
# frozen_string_literal: true

class Permission < ApplicationRecord
  belongs_to :holder, polymorphic: true
end
