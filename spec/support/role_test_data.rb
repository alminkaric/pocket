# typed: strict
# frozen_string_literal: true

class RoleTestData
  NAME = 'Test Role'

  class << self
    extend T::Sig

    sig { params(name: T.nilable(String)).returns(Role) }
    def get_or_create_role(name = nil)
      role = get_or_build_role(name)
      role_service.save(role)
      role
    end

    sig { params(name: T.nilable(String)).returns(Role) }
    def get_or_build_role(name = nil)
      name = NAME if name.blank?
      Role.find_or_initialize_by(name: name)
    end

    private

    sig { returns(RoleService) }
    def role_service
      @role_service = T.let(@role_service, T.nilable(RoleService))
      @role_service ||= ServiceFactory.role_service(User.admin_user)
    end
  end
end
