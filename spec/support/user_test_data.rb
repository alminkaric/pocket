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
      users = find_user_service.call({ email: email })
      user = users.first
      return user if user

      create_user_service.call(email: email, password: PASSWORD)
    end

    sig { params(email: T.nilable(String)).returns(User) }
    def get_or_create_admin_user(email = nil)
      email ||= ADMIN_EMAIL
      users = find_user_service.call({ email: email })
      user = users.first
      return user if user && role_service.user_role?(user: user, role: Role.admin)

      user = get_or_create_user(email)
      role_service.assign_role_to_user(user: user, role: Role.admin)
      user
    end

    private

    sig { returns(TempUserService::GetUserService) }
    def get_user_service
      T.cast(ServiceFactory.get_service(TempUserService, ECrud::GET, User.admin), TempUserService::GetUserService)
    end

    sig { returns(TempUserService::CreateUserService) }
    def create_user_service
      T.cast(ServiceFactory.get_service(TempUserService, ECrud::CREATE, User.admin), TempUserService::CreateUserService)
    end

    sig { returns(TempUserService::FindByUserService) }
    def find_user_service
      T.cast(ServiceFactory.get_service(TempUserService, ECrud::FIND, User.admin), TempUserService::FindByUserService)
    end

    sig { returns(RoleService) }
    def role_service
      ServiceFactory.role_service(User.admin)
    end
  end
end
