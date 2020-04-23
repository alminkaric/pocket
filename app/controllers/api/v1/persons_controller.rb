# frozen_string_literal: true

module Api
  module V1
    class PersonsController < ApiBaseController
      include JsonRenderHelper
      def index
        people = person_service.load_all
        render_json(people)
      end

      def show
        person = person_service.get(params[:id])
        render_json(person)
      end

      def create
        person = person_service.create(params)
        render_json(person)
      end

      def update
        person = person_service.update(params)
        render_json(person)
      end

      private

      # services...

      def person_service
        @person_service ||= PersonService.new
      end
    end
  end
end
