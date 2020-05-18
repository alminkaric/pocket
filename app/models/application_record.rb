# typed: strict
# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  extend T::Sig
  extend T::Helpers
  abstract!

  self.abstract_class = true
end
