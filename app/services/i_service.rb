# typed: strict
# frozen_string_literal: true

module IService
  extend T::Sig
  extend T::Helpers
  interface!

  sig { abstract.params(args: T.untyped).returns(T.untyped) }
  def call(args); end
end
