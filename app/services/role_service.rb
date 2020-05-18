# typed: strict
# frozen_string_literal: true

#
## Service for accessing [Role]
#
# @see Role
# @author Almin Karic <almin.karic.3t1@gmail.com>
#
class RoleService
  extend T::Sig
  include IService

  sig { params(permission_service: PermissionService).void }
  def initialize(permission_service)
    @permission_service = permission_service
  end

  sig { override.params(id: Integer).returns(Role) }
  def get(id)
    ServiceUtils.get(id, Role)
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

  sig { override.returns(T::Array[Role]) }
  def load_all
    ServiceUtils.load_all(Role)
  end

  sig { override.params(role: Role).returns(Role) }
  def save(role)
    @permission_service.check_user_permission_for('save')

    ServiceUtils.save(role, Role)
  end

  sig { override.params(role: Role).void }
  def delete(role)
    @permission_service.check_user_permission_for('delete')

    ServiceUtils.delete(role, Role)
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
end
