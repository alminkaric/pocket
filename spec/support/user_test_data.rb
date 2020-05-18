# typed: strict
# frozen_string_literal: true

class UserTestData
  extend T::Sig
  EMAIL = 'jon.snow@got.com'
  PASSWORD = 'testpass1234'

  sig { returns(User) }
  attr_reader :admin_user, :normal_user

  sig { void }
  def initialize
    @admin_user = T.let(User.admin_user, User)
    @user_service = T.let(ServiceFactory.user_service(User.admin_user), UserService)
    @role_service = T.let(ServiceFactory.role_service(User.admin_user), RoleService)

    @normal_user = T.let(get_or_create_user('normal-user@pocket.com'), User)
  end

  sig { params(email: String).returns(User) }
  def get_or_create_user(email)
    user = @user_service.find_user_by_email(email)
    return user if user.present?

    @user_service.create(email: email, password: PASSWORD)
  end

  sig { params(email: String).returns(User) }
  def get_or_create_admin_user(email)
    user = @user_service.find_user_by_email(email)
    return user if user && @role_service.user_role?(user: user, role: Role.admin)

    user = get_or_create_user(email)
    @role_service.assign_role_to_user(user: user, role: Role.admin)
    user
  end
end
