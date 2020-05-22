# typed: strict
# frozen_string_literal: true

class ValidationError < StandardError
  extend T::Sig
  sig { params(errors: ActiveModel::Errors, msg: String).void }
  def initialize(errors, msg = 'Validation for the record failed')
    super("#{msg} with errors=#{errors.to_h}")
    @errors = errors
  end

  sig { returns(ActiveModel::Errors) }
  attr_reader :errors
end
