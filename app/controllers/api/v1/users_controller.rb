# typed: strict
# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApiBaseController
      final!

      sig(:final) { void }
      def index
        users = User.all
        render_json(users)
      end
    end
  end
end
