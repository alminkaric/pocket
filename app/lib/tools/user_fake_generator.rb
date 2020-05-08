# frozen_string_literal: true

module Tools
  class UserFakeGenerator
    class << self
      def get_or_create_user(email)
        user = user_service.find_user_by_email(email)
        return user if user.present?

        user_service.create(email: email, password: password)
      end

      def get_or_create_admin_user(email)
        user = user_service.find_user_by_email(email)
        return user if role_service.user_role?(user: user, role: Role::ADMIN)

        user = get_or_create_user(email)
        role_service.assign_role_to_user(user: user, role: Role::ADMIN)
        user
      end

      private

      def password
        Faker::Internet.password(min_length: 8)
      end

      def user_service
        @user_service ||= UserService.new
      end

      def role_service
        @role_service ||= RoleService.new
      end
    end
  end
end
