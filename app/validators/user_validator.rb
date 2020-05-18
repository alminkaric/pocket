# typed: true
# frozen_string_literal: true

class UserValidator < ApplicationValidator
  # @return [boolean]
  def validate(user)
    @model.email = user.email
    @model.password = user.password
    @model.valid?
  end

  protected

  class UserValidatorModel < User
  end

  def validator_model
    UserValidatorModel
  end

  private_constant :UserValidatorModel
end
