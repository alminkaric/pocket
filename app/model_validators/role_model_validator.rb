# typed: strict
# frozen_string_literal: true

class RoleModelValidator
  extend T::Sig
  include ActiveModel::Validations
  include IModelValidator

  sig { returns(String) }
  attr_accessor :name

  sig { override.returns(T.class_of(ApplicationRecord)) }
  attr_reader :model

  validates :name, presence: true, length: { minimum: 3 }, unique: true

  sig { void }
  def initialize
    @name = T.let('', String)
    @model = T.let(Role, T.class_of(ApplicationRecord))
  end

  sig { override.params(role: Role).void }
  def init(role)
    self.name = role.name
  end
end
