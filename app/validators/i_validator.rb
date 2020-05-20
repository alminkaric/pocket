# typed: strict
# frozen_string_literal: true

module IValidator
  extend T::Sig
  extend T::Helpers
  interface!

  sig { abstract.returns(T::Boolean) }
  def valid?; end

  sig { abstract.returns(ActiveModel::Errors) }
  def errors; end
end
