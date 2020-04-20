# frozen_string_literal: true

module Api
  module V1
    class ClientsController < ApiBaseController
      def index
        id = params[:id].to_i
        clients = if id.positive?
                    Client.where(id: id)
                  else
                    Client.all
                  end
        response.set_header('X-Total-Count', clients.size)
        start_index = params[:_start].to_i
        end_index = params[:_end].to_i
        @output = clients
        if end_index > start_index
          @output = clients.slice(start_index, end_index - start_index)
        end
        render json: @output
      end

      def show
        client = client_service.get(params[:id])
        render json: client
      end

      private

      def client_service
        @client_service ||= ClientService.new
      end
    end
  end
end
