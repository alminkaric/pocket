module Api
  module V1
    class UsersController < ActionController::API
      def index
        @users = User.all
        response.set_header('X-Total-Count', @users.size)
        start_index = params[:_start].to_i
        end_index = params[:_end].to_i
        @output = @users.slice(start_index, end_index - start_index)
        render json: @output
      end
    end
  end
end