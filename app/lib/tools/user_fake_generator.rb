# typed: true
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
        return user if role_service.user_role?(user: user, role: Role.admin)

        user = get_or_create_user(email)
        role_service.assign_role_to_user(user: user, role: Role.admin)
        user
      end

      private

      def password
        Faker::Internet.password(min_length: 8)
      end

      def user_service
        @user_service ||= ServiceFactory.user_service
      end

      def role_service
        @role_service ||= ServiceFactory.role_service
      end
    end
  end
end
