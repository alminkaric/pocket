# frozen_string_literal: true

#
## Service for accessing [Role]
#
# @see Role
# @author Almin Karic <almin.karic.3t1@gmail.com>
#
class RoleService < ApplicationService
  # @return [Role,nil]
  def find_by_name(name)
    klass.find_by(name: name)
  end

  #
  # Finds or creates a role based on role name.
  #
  # @param [String] role_name
  def find_or_create(role_name)
    role = find_by_name(role_name)
    return role if role.present?

    role = Role.new
    role.name = role_name
    save(role)
  end

  def save(role)
    permission_service.check_user_permission_for('save')

    super(role)
  end

  #
  # Checks if user has given role
  #
  # @param [User] user
  # @param [Role] role
  #
  # @return [Boolean]
  #
  def user_role?(user:, role:)
    return false if user.nil? || user.new_record?

    user.roles.include? role
  end

  def assign_role_to_user(role:, user:)
    permission_service.check_user_permission_for('assign_role_to_user')
    RoleAssignment.create(role: role, user: user)
  end

  protected

  def klass
    Role
  end

  private

  def permission_service
    @permission_service ||= PermissionService.new(current_user: @current_user, class_to_check: self.class)
  end
end
