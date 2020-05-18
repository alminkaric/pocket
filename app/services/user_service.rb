# typed: strict
# frozen_string_literal: true

class UserService
  extend T::Sig
  include IService

  sig { params(permission_service: PermissionService, role_service: RoleService).void }
  def initialize(permission_service:, role_service:)
    @permission_service = permission_service
    @role_service = role_service
  end

  sig { override.params(id: Integer).returns(User) }
  def get(id)
    ServiceUtils.get(id, User)
  end

  sig { override.returns(T::Array[User]) }
  def load_all
    ServiceUtils.load_all(User)
  end

  sig { params(email: String).returns(T.nilable(User)) }
  def find_user_by_email(email)
    User.find_by(email: email)
  end

  sig { params(email: String, password: String).returns(User) }
  def create(email:, password:)
    user = User.new
    user.email = email
    user.password = password
    save(user)
  end

  sig { params(email: String, password: String).returns(User) }
  def create_admin_user(email:, password:)
    @permission_service.check_user_permission_for('create_admin_user')

    user = create(email: email, password: password)
    @role_service.assign_role_to_user(role: Role.admin, user: user)
    user
  end

  sig { override.params(user: User).returns(User) }
  def save(user)
    @permission_service.check_user_permission_for('save') unless user.new_record?

    ServiceUtils.save(user, User)
  end

  sig { override.params(user: User).void }
  def delete(user)
    @permission_service.check_user_permission_for('delete')

    ServiceUtils.delete(user, User)
  end
end
