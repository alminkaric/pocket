# typed: strict
# frozen_string_literal: true

class PermissionUniqueValidator < ActiveModel::Validator
  extend T::Sig

  sig { params(permission: PermissionModelValidator).void }
  def validate(permission)
    permission.errors.add :holder, 'Permssion holder already exists' unless permission_unique?(permission)
  end

  private

  sig { params(permission: PermissionModelValidator).returns(T::Boolean) }
  def permission_unique?(permission)
    permission_params = {
      class_name: permission.class_name,
      method_name: permission.method_name,
      holder_id: permission.holder_id,
      holder_type: permission.holder_type
    }
    existing_permission = Permission.find_by(permission_params)
    return true if existing_permission.nil? || existing_permission.id == permission.id

    false
  end
end
