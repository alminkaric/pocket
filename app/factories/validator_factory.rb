# typed: ignore
# frozen_string_literal: true

class ValidatorFactory
  class << self
    extend T::Sig

    sig { params(validator_class: Class).returns(IValidator) }
    def get_validator(validator_class)
      T.cast(validator_class.new, IValidator)
    rescue TypeError
      # can happen when runing rspec so the 'T.cast(validator_class.new, IValidator)' fails
      validator_class_string = T.let(T.must(validator_class.name), String)
      validator_class = Kernel.const_get(validator_class_string)
      T.cast(validator_class.new, IValidator)
    end
  end
end
