# typed: strict
# frozen_string_literal: true

module TempUserService
  class GetUserService
    extend T::Sig
    include IService

    sig { params(crud: ICrud, permission_service: PermissionService, current_user: User).void }
    def initialize(crud, permission_service, current_user)
      @crud = crud
      @permission_service = permission_service
      @current_user = current_user
    end

    sig { override.params(id: Integer).returns(User) }
    def call(id)
      @permission_service.check_user_permission_for('call') unless @current_user.id == id
      T.cast(@crud.get(id), User)
    end
  end
end
