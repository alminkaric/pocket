# typed: strict
# frozen_string_literal: true

class BaseValidator
  extend T::Sig
  include IValidator

  sig { params(validator: IValidator).void }
  def initialize(validator)
    @validator = validator
  end

  sig { override.params(record: ApplicationRecord).void }
  def init(record)
    @validator.init(record)
  end

  sig { override.returns(T::Boolean) }
  def valid?
    @validator.valid?
  end

  sig { override.returns(ActiveModel::Errors) }
  def errors
    @validator.errors
  end
end
