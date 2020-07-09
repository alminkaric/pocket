# typed: strict
# frozen_string_literal: true

module TempUserService
  class CreateAdminUserService
    extend T::Sig
    include IService

    sig do
      params(
        create_service: IService,
        role_service: RoleService,
        permission_service: PermissionService
      ).void
    end
    def initialize(create_service:, role_service:, permission_service:)
      @create_service = create_service
      @role_service = role_service
      @permission_service = permission_service
    end

    sig { override.params(args: { email: String, password: String }).returns(User) }
    def call(args)
      @permission_service.check_user_permission_for('call')

      user = @create_service.call(args)
      @role_service.assign_role_to_user(role: Role.admin, user: user)
      user
    end
  end
end
