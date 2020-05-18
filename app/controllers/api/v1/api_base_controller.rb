# typed: strict
# frozen_string_literal: true

module Api
  module V1
    ##
    # Base controller for V1 api
    #
    class ApiBaseController < ActionController::API
      extend T::Sig
      extend T::Helpers
      include JsonRenderHelper
      abstract!

      sig { void }
      def initialize
        super
        @services = T.let({}, T::Hash[Symbol, IService])
      end
    end
  end
end
