# typed: strict
# frozen_string_literal: true

module TempUserService
  class DeleteUserService
    extend T::Sig
    include IService

    sig { params(crud: ICrud, permission_service: PermissionService).void }
    def initialize(crud:, permission_service:)
      @crud = crud
      @permission_service = permission_service
    end

    sig { override.params(user: User).void }
    def call(user)
      @permission_service.check_user_permission_for('call')
      @crud.delete(user)
    end
  end
end
