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
    end
  end
end
