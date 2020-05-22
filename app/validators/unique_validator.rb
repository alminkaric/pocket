# typed: strict
# frozen_string_literal: true

class UniqueValidator < ActiveModel::EachValidator
  extend T::Sig

  sig { params(record: IModelValidator, attribute: Symbol, value: T.untyped).void }
  def validate_each(record, attribute, value)
    model = record.model
    existing_records = T.let(model.where(attribute => value), ActiveRecord::Relation)
    record.errors.add attribute, 'must be unique' if !existing_records.empty? && existing_records != record
  end
end
