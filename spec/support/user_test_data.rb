# typed: strict
# frozen_string_literal: true

class UserTestData
  extend T::Sig
  ADMIN_EMAIL = 'admin@user.com'
  EMAIL = 'jon.snow@got.com'
  PASSWORD = 'testpass1234'

  class << self
    extend T::Sig
    sig { params(email: T.nilable(String)).returns(User) }
    def get_or_create_user(email = nil)
      email ||= EMAIL
      user = user_service.find_user_by_email(email)
      return user if user.present?

      user_service.create(email: email, password: PASSWORD)
    end

    sig { params(email: T.nilable(String)).returns(User) }
    def get_or_create_admin_user(email = nil)
      email ||= ADMIN_EMAIL
      user = user_service.find_user_by_email(email)
      return user if user && role_service.user_role?(user: user, role: Role.admin)

      user = get_or_create_user(email)
      role_service.assign_role_to_user(user: user, role: Role.admin)
      user
    end

    private

    sig { returns(UserService) }
    def user_service
      ServiceFactory.user_service(User.admin)
    end

    sig { returns(RoleService) }
    def role_service
      ServiceFactory.role_service(User.admin)
    end
  end
end
