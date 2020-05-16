# frozen_string_literal: true

class ApplicationValidator
  def initialize
    @model = validator_model.new
  end

  # return [boolean]
  def validate(_model)
    raise NotImplementedError 'validate model needs to be implemented'
  end

  def errors
    @model.errors
  end

  protected

  def validator_model
    raise NotImplementedError 'Validator model needs to be implemented'
  end
end
