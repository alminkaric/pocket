# typed: strict
# frozen_string_literal: true

class ApplicationValidator
  extend T::Sig
  extend T::Helpers
  abstract!

  sig { void }
  def initialize
    @model = T.let(validator_model.new, T.untyped)
  end

  # return [boolean]
  sig { abstract.params(_model: T.untyped).returns(T::Boolean) }
  def validate(_model); end

  sig { returns(ActiveModel::Errors) }
  def errors
    @model.errors
  end

  protected

  sig { abstract.returns(T.class_of(ApplicationRecord)) }
  def validator_model; end
end
