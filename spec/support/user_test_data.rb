# frozen_string_literal: true

class UserTestData
  EMAIL = 'jon.snow@got.com'
  PASSWORD = 'testpass1234'

  attr_reader :admin_user, :normal_user

  def initialize
    @admin_user = User.admin_user
    @normal_user = get_or_create_user('normal-user@pocket.com')
  end

  def get_or_create_user(email)
    user = user_service.find_user_by_email(email)
    return user if user.present?

    user_service.create(email: email, password: PASSWORD)
  end

  def get_or_create_admin_user(email)
    user = user_service.find_user_by_email(email)
    return user if role_service.user_role?(user: user, role: Role.admin)

    user = get_or_create_user(email)
    role_service.assign_role_to_user(user: user, role: Role.admin)
    user
  end

  private

  def user_service
    @user_service ||= UserService.new(User.admin_user)
  end

  def role_service
    @role_service ||= RoleService.new(User.admin_user)
  end
end
