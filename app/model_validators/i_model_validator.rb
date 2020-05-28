# typed: strict
# frozen_string_literal: true

module IModelValidator
  extend T::Sig
  extend T::Helpers
  include IValidator
  interface!

  sig { abstract.returns(T.class_of(ApplicationRecord)) }
  def model; end
end
