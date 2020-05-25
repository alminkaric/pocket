# typed: strict
# frozen_string_literal: true

class ClassExistValidator < ActiveModel::EachValidator
  extend T::Sig

  sig { params(record: IModelValidator, attribute: Symbol, value: T.untyped).void }
  def validate_each(record, attribute, value)
    class_name = T.let(value, String)
    record.errors.add attribute, "Class #{class_name} doesn't exist" unless class_exists?(class_name)
  end

  private

  sig { params(class_name: String).returns(T::Boolean) }
  def class_exists?(class_name)
    Kernel.const_get(class_name).present?
  rescue NameError
    false
  end
end
