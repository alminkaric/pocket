# frozen_string_literal: true

module Tools
  class RoleFakeGenerator
    class << self
      # @return [User]
      def get_or_create_role(role_name)
        role = role_service.find_by_name(role_name)
        return role if role.present?

        role = Role.new(name: role_name)
        role_service.save(role)
      end

      private

      def role_service
        @role_service ||= RoleService.new
      end
    end
  end
end
