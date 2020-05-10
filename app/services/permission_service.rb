# frozen_string_literal: true

# TODO: Add doc
class PermissionService < ApplicationService
  def initialize(current_user: nil, class_to_check:)
    super(current_user)
    @class_name = class_to_check.name
  end

  # @return [void]
  def check_user_permission_for(method_name)
    user_has_permission = user_permission_for?(method_name)
    raise PermissionError unless user_has_permission
  end

  # @return [Permission]
  def save(permission)
    check_user_permission_for('save')
    super(permission)
  end

  # @return [void]
  def delete(permission)
    check_user_permission_for('delete')
    super(permission)
  end

  protected

  def klass
    Permission
  end

  private

  def holder_is_role?(permission)
    permission_holder = permission.holder
    permission_holder.is_a? Role
  end

  # @return [boolean]
  def user_permission_for?(method_name)
    raise ArgumentError, "Argument `method_name` can't be empty" if method_name.blank?
    return false if @current_user.nil?

    method_name = method_name.to_s
    permissions = find_permissions_by(class_name: @class_name, method_name: method_name)
    role_permissions = find_role_permissions(permissions)

    intersection = role_permissions & @current_user.roles
    has_common_elements = intersection.any?
    has_common_elements
  end

  # @return [Array<Permission>]
  def find_permissions_by(class_name:, method_name:)
    Permission.where(class_name: class_name, method_name: method_name)
  end

  # @return [Array<Role>]
  def find_role_permissions(permissions)
    permissions
      .select { |permission| holder_is_role?(permission) }
      .map(&:holder)
      .uniq
  end
end
