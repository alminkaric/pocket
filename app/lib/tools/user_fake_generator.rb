# frozen_string_literal: true

module Tools
  class UserFakeGenerator
    class << self
      def get_or_create_user(email)
        user = user_service.find_user_by_email(email)
        return user if user.present?

        password = Faker::Internet.password(min_length: 8)
        user_service.create(email: email, password: password)
      end

      def get_or_create_admin_user(email)
        user = get_or_create_user(email)
        admin_role = RoleFakeGenerator.get_or_create_role('Admin')
        role_service.assign_role_to_user(role: admin_role, user: user)
        user
      end

      private

      def user_service
        @user_service ||= UserService.new
      end

      def role_service
        @role_service ||= RoleService.new
      end
    end
  end
end
