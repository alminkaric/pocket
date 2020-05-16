# frozen_string_literal: true

class RoleValidator < ApplicationValidator
  def validate(role)
    @model.name = role.name
    @model.valid?
  end

  protected

  class RoleValidatorModel < Role
    validates_presence_of :name
    validates_uniqueness_of :name
  end

  def validator_model
    RoleValidatorModel
  end

  private_constant :RoleValidatorModel
end
