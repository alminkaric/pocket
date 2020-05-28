# typed: strict
# frozen_string_literal: true

class BaseServiceValidatorImpl
  extend T::Sig
  include IServiceValidator

  sig { params(validator: IValidator).void }
  def initialize(validator)
    @validator = validator
  end

  sig { override.params(record: ApplicationRecord).void }
  def validate(record)
    @validator.init(record)
    raise ValidationError, @validator.errors unless @validator.valid?
  end
end
