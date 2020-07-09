# typed: strict
# frozen_string_literal: true

module TempUserService
  class CreateUserService
    extend T::Sig
    include IService

    sig { params(crud: ICrud, permission_service: PermissionService).void }
    def initialize(crud:, permission_service:)
      @crud = crud
      @permission_service = permission_service
    end

    sig { override.params(args: { email: String, password: String }).returns(User) }
    def call(args)
      @permission_service.check_user_permission_for('call')

      T.cast(@crud.create(args), User)
    end
  end
end
