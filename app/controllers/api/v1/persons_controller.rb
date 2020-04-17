module Api
  module V1
    class PersonsController < ApiBaseController

      def index
        @people = Person.all
        response.set_header('X-Total-Count', @people.size)
        start_index = params[:_start].to_i
        end_index = params[:_end].to_i
        @output = @people.slice(start_index, end_index - start_index)
        render json: @output, each_serializer: ::PersonSerializer
      end
    end
  end
end