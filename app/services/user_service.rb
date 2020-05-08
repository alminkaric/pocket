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
    role_service.assign_role_to_user(role: Role::ADMIN, user: user)
    user
  end

  # @return [User]
  def save(user)
    permission_service.check_user_permission_for('save') unless user.new_record?

    super(user)
  end

  def delete(user)
    permission_service.check_user_permission_for('delete')

    super(user)
  end

  protected

  def klass
    User
  end

  private

  def role_service
    @role_service ||= RoleService.new(@current_user)
  end

  def permission_service
    @permission_service ||=
      PermissionService.new(current_user: @current_user, class_to_check: self.class)
  end

  def current_user_can_use_save?(user)
    return true if user.new_record?
    return true if permission_service.user_permission_for?('save')

    false
  end
end
