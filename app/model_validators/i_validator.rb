# typed: strict
# frozen_string_literal: true

module IValidator
  extend T::Sig
  extend T::Helpers
  interface!

  sig { abstract.params(record: T.untyped).void }
  def init(record); end

  sig { abstract.returns(T::Boolean) }
  def valid?; end

  sig { abstract.returns(ActiveModel::Errors) }
  def errors; end
end
