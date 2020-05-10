# frozen_string_literal: true

# TODO: Add doc
class PermissionService < ApplicationService
  def initialize(current_user: nil, class_to_check:)
    super(current_user)
    @class_name = class_to_check.name
  end

  def user_permission_for?(method_name)
    return false if @current_user.nil?

    method_name = method_name.to_s
    permissions = find_permissions_by(class_name: @class_name, method_name: method_name)
    role_permissions = permissions
                       .select { |permission| holder_is_role?(permission) }
                       .map(&:holder)
                       .uniq

    intersection = role_permissions & @current_user.roles
    has_common_elements = intersection.any?
    has_common_elements
  end

  # @return [void]
  def check_user_permission_for(method_name)
    user_has_permission = user_permission_for?(method_name)
    raise PermissionError unless user_has_permission
  end

  # @return [Array<Permission>]
  def find_permissions_by(class_name:, method_name:)
    Permission.where(class_name: class_name, method_name: method_name)
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
end
