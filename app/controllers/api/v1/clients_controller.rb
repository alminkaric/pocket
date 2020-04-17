module Api
  module V1
    class ClientsController < ApiBaseController

      def index
        @clients = Client.all
        response.set_header('X-Total-Count', @clients.size)
        start_index = params[:_start].to_i
        end_index = params[:_end].to_i
        @output = @clients.slice(start_index, end_index - start_index)
        render json: @output
      end
    end
  end
end