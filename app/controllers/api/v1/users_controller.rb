# typed: strict
# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApiBaseController
      final!

      sig(:final) { void }
      def index
        users = user_service.load_all
        render_json(users)
      end

      private

      sig(:final) { returns(UserService) }
      def user_service
        @user_service = T.let(@user_service, T.nilable(UserService))
        @user_service ||= ServiceFactory.user_service(current_user)
      end
    end
  end
end
