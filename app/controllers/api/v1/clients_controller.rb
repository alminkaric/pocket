# typed: true
# frozen_string_literal: true

module Api
  module V1
    class ClientsController < ApiBaseController
      include JsonRenderHelper
      def index
        clients = client_service.find_by_ids_or_all(params[:id])
        render_json(clients)
      end

      def show
        client = client_service.get(params[:id])
        render_json(client)
      end

      private

      def client_service
        @client_service ||= ClientService.new
      end
    end
  end
end
