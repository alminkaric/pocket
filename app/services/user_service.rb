# frozen_string_literal: true

class UserService < ApplicationService
  # @return [User]
  def find_user_by_email(email)
    User.find_by(email: email)
  end

  # @return [User]
  def create(email:, password:)
    user = User.new
    user.email = email
    user.password = password
    save(user)
  end

  # @return [User]
  def create_admin_user(email:, password:)
    permission_service.check_user_permission_for('create_admin_user')

    user = create(email: email, password: password)
    role_service.assign_role_to_user(role: Role.admin, user: user)
    user
  end

  # @return [User]
  def save(user)
    permission_service.check_user_permission_for('save') unless user.new_record?

    super(user)
  end

  # @return [void]
  def delete(user)
    permission_service.check_user_permission_for('delete')

    super(user)
  end

  private

  def klass
    User
  end

  def role_service
    @role_service ||= RoleService.new(@current_user)
  end

  def permission_service
    @permission_service ||=
      PermissionService.new(current_user: @current_user, class_to_check: self.class)
  end
end
