# typed: strong
# frozen_string_literal: true

class ServiceFactory
  extend T::Sig
  class << self
    extend T::Sig

    sig { params(current_user: T.nilable(User)).returns(UserService) }
    def user_service(current_user = nil)
      permission_service = permission_service(UserService, current_user)
      role_service = role_service(current_user)
      UserService.new(permission_service: permission_service, role_service: role_service)
    end

    sig { params(class_to_check: Class, current_user: T.nilable(User)).returns(PermissionService) }
    def permission_service(class_to_check, current_user = nil)
      class_name = T.must(class_to_check.name)
      PermissionService.new(class_name: class_name, current_user: current_user)
    end

    sig { params(current_user: T.nilable(User)).returns(RoleService) }
    def role_service(current_user = nil)
      RoleService.new(permission_service(RoleService, current_user))
    end
  end
end
