# typed: strict
# frozen_string_literal: true

module TempUserService
  class UpdateUserService
    extend T::Sig
    include IService

    sig do
      params(
        crud: ICrud,
        permission_service: PermissionService,
        current_user: T.nilable(User)
      ).void
    end
    def initialize(crud:, permission_service:, current_user: nil)
      @crud = crud
      @permission_service = permission_service
      @current_user = current_user
    end

    sig { override.params(user: User).returns(User) }
    def call(user)
      @permission_service.check_user_permission_for('call') unless user.new_record? || own_user?(user)

      T.cast(@crud.update(user), User)
    end

    private

    sig { params(user: User).returns(T::Boolean) }
    def own_user?(user)
      return false unless @current_user

      user == @current_user
    end
  end
end
