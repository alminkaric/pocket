# typed: strict
# frozen_string_literal: true

class ServiceUtils::Tools
  class << self
    extend T::Sig

    sig { params(model: ApplicationRecord, validator: IValidator).void }
    def validate(model, validator)
      validator.init(model)
      raise ValidationError, validator.errors unless validator.valid?
    end
  end
end
