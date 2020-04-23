# frozen_string_literal: true

module Api
  module V1
    class ClientsController < ApiBaseController
      include JsonRenderHelper
      def index
        id = params[:id].to_i
        clients = if id.positive?
                    Client.where(id: id)
                  else
                    Client.all
                  end
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
