# typed: strict
# frozen_string_literal: true

#
## Service for accessing [Role]
#
# @see Role
# @author Almin Karic <almin.karic.3t1@gmail.com>
#
class RoleService < ApplicationService
  sig { params(current_user: T.nilable(User)).void }
  def initialize(current_user = nil)
    super(current_user)

    @permission_service = T.let(PermissionService.new(current_user: @current_user, class_to_check: self.class), PermissionService)
  end

  # @return [Role,nil]
  sig { params(name: String).returns(T.nilable(Role)) }
  def find_by_name(name)
    Role.find_by(name: name)
  end

  #
  # Finds or creates a role based on role name.
  #
  # @param [String] role_name
  sig { params(role_name: String).returns(Role) }
  def find_or_create(role_name)
    role = find_by_name(role_name)
    return role if role.present?

    role = Role.new
    role.name = role_name
    save(role)
  end

  sig { params(role: Role).returns(Role) }
  def save(role)
    @permission_service.check_user_permission_for('save')

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
  sig { params(user: User, role: Role).returns(T::Boolean) }
  def user_role?(user:, role:)
    return false if user.new_record?

    user.roles.include? role
  end

  sig { params(role: T.untyped, user: T.untyped).returns(RoleAssignment) }
  def assign_role_to_user(role:, user:)
    @permission_service.check_user_permission_for('assign_role_to_user')
    RoleAssignment.create(role: role, user: user)
  end

  private

  sig { returns(T.class_of(Role)) }
  def klass
    Role
  end
end
