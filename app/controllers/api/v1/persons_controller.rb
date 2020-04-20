# frozen_string_literal: true

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

      def show
        person = person_service.get(params[:id])
        render json: person, serializer: ::PersonSerializer
      end

      def create
        person = person_service.create_person(params)
        render json: person, serializer: ::PersonSerializer
      end

      private

      # services...

      def person_service
        @person_service ||= PersonService.new
      end
    end
  end
end
