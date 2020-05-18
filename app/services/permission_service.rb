# typed: strict
# frozen_string_literal: true

# TODO: Add doc
class PermissionService
  extend T::Sig
  include IService

  sig { params(class_name: String, current_user: T.nilable(User)).void }
  def initialize(class_name:, current_user: nil)
    @class_name = class_name
    @current_user = current_user
  end

  sig { override.params(id: Integer).returns(Permission) }
  def get(id)
    ServiceUtils.get(id, Permission)
  end

  sig { override.returns(T::Array[Permission]) }
  def load_all
    ServiceUtils.load_all(Permission)
  end

  sig { params(method_name: String).void }
  def check_user_permission_for(method_name)
    user_has_permission = user_permission_for?(method_name)
    raise PermissionError unless user_has_permission
  end

  sig { override.params(permission: Permission).returns(ApplicationRecord) }
  def save(permission)
    check_user_permission_for('save')
    ServiceUtils.save(permission, Permission)
  end

  sig { override.params(permission: Permission).void }
  def delete(permission)
    check_user_permission_for('delete')

    ServiceUtils.delete(permission, Permission)
  end

  sig { params(permission: Permission).returns(T::Boolean) }
  def holder_is_role?(permission)
    permission_holder = permission.holder
    permission_holder.is_a? Role
  end

  sig { params(method_name: String).returns(T::Boolean) }
  def user_permission_for?(method_name)
    raise ArgumentError, "Argument `method_name` can't be empty" if method_name.blank?
    return false if @current_user.nil?

    method_name = method_name.to_s
    permissions = find_permissions_by(class_name: @class_name, method_name: method_name)
    role_permissions = find_role_permissions(permissions)

    intersection = role_permissions & @current_user.roles.to_a
    has_common_elements = intersection.any?
    has_common_elements
  end

  sig { params(class_name: String, method_name: String).returns(Permission::ActiveRecord_Relation) }
  def find_permissions_by(class_name:, method_name:)
    Permission.where(class_name: class_name, method_name: method_name)
  end

  sig { params(permissions: Permission::ActiveRecord_Relation).returns(T::Array[Role]) }
  def find_role_permissions(permissions)
    permissions
      .select { |permission| holder_is_role?(permission) }
      .map(&:holder)
      .uniq
  end
end
