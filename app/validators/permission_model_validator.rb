# typed: strict
# frozen_string_literal: true

class PermissionModelValidator
  extend T::Sig
  include ActiveModel::Validations
  include IModelValidator

  sig { returns(String) }
  attr_reader :class_name, :method_name, :holder_type

  sig { returns(Integer) }
  attr_reader :holder_id

  sig { returns(T.nilable(Integer)) }
  attr_reader :id

  validates :class_name, presence: true, class_exist: true
  validates :method_name, presence: true
  validates :holder_id, presence: true
  validates :holder_type, presence: true
  validates_with PermissionUniqueValidator

  sig { void }
  def initialize
    @id = T.let(nil, T.nilable(Integer))
    @class_name = T.let('', String)
    @method_name = T.let('', String)
    @holder_id = T.let(0, Integer)
    @holder_type = T.let('', String)
  end

  sig { override.returns(T.class_of(ApplicationRecord)) }
  def model
    Permission
  end

  sig { override.params(permission: Permission).void }
  def init(permission)
    @id = permission.id
    @class_name = permission.class_name
    @method_name = permission.method_name
    @holder_id = permission.holder_id
    @holder_type = permission.holder_type
  end
end
