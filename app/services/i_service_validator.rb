# typed: strict
# frozen_string_literal: true

module IServiceValidator
  extend T::Sig
  extend T::Helpers
  interface!

  sig { abstract.params(record: ApplicationRecord).void }
  def validate(record); end
end
