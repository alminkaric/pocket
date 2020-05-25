# typed: strict
# frozen_string_literal: true

class PermissionTestData
  CLASS_NAME = 'PermissionService'
  METHOD_NAME = 'get'

  class << self
    extend T::Sig

    sig { params(class_name: T.nilable(String), method_name: T.nilable(String)).returns(Permission) }
    def get_or_create(class_name = nil, method_name = nil)
      permission = get_or_build(class_name, method_name)
      permission_service.save(permission)
      permission
    end

    sig { params(class_name: T.nilable(String), method_name: T.nilable(String)).returns(Permission) }
    def get_or_build(class_name = nil, method_name = nil)
      class_name = CLASS_NAME if class_name.blank?
      method_name = METHOD_NAME if method_name.blank?
      Permission.find_or_initialize_by(class_name: class_name, method_name: method_name)
    end

    private

    sig { returns(PermissionService) }
    def permission_service
      @permission_service = T.let(@permission_service, T.nilable(PermissionService))
      @permission_service ||= ServiceFactory.permission_service(PermissionService, User.admin)
    end
  end
end
