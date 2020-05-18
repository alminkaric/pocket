# typed: strict
# frozen_string_literal: true

class UserService < ApplicationService
  sig { params(current_user: T.nilable(User)).void }
  def initialize(current_user = nil)
    super(current_user)
    @permission_service = T.let(PermissionService.new(current_user: @current_user, class_to_check: self.class), PermissionService)
    @role_service = T.let(RoleService.new(@current_user), RoleService)
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

  sig { params(user: User).returns(User) }
  def save(user)
    @permission_service.check_user_permission_for('save') unless user.new_record?

    super(user)
  end

  sig { params(user: User).void }
  def delete(user)
    @permission_service.check_user_permission_for('delete')

    super(user)
  end

  private

  sig { returns(T.class_of(User)) }
  def klass
    User
  end
end
