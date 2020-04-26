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

      private

      def user_service
        @user_service ||= UserService.new
      end
    end
  end
end
