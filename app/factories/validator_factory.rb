# typed: strict
# frozen_string_literal: true

class ValidatorFactory
  class << self
    extend T::Sig

    sig { params(role: Role).returns(IValidator) }
    def role_validator(role)
      role_validator = RoleValidator.new(role.attributes)
      base_validator(role_validator)
    end

    private

    sig { params(validator: IValidator).returns(BaseValidator) }
    def base_validator(validator)
      BaseValidator.new(validator)
    end
  end
end
