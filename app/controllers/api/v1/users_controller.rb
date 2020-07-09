# typed: strict
# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApiBaseController
      final!

      sig(:final) { void }
      def index
        service = ServiceFactory.get_service(TempUserService, ECrud::LOAD_ALL)
        users = service.call(nil)
        render_json(users)
      end

      private

      sig(:final) { returns(IServiceFactory) }
      def user_service_factory
        @user_service_factory = T.let(@user_service_factory, T.nilable(TempUserService::ServiceFactory))
        @user_service_factory ||= TempUserService::ServiceFactory.new(current_user)
      end
    end
  end
end
