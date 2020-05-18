# typed: true
# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApiBaseController
      include JsonRenderHelper
      def index
        users = user_service.load_all
        render_json(users)
      end

      private

      def user_service
        @user_service ||= UserService.new
      end
    end
  end
end
