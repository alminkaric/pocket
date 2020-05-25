# typed: strict
# frozen_string_literal: true

module Api
  module V1
    class PersonsController < ApiBaseController
      include JsonRenderHelper

      sig { void }
      def index
        people = person_service.load_all
        render_json(people)
      end

      sig { void }
      def show
        person = person_service.get(person_from_request.id)
        render_json(person)
      end

      sig { void }
      def create
        person = person_service.save(person_from_request)
        render_json(person)
      end

      sig { void }
      def update
        person = person_service.save(person_from_request)
        render_json(person)
      end

      private

      sig { returns(ActionController::Parameters) }
      def permitted_params
        params.permit(:id, :email, :first_name, :last_name, :client_id)
      end

      sig { returns(Person) }
      def person_from_request
        Person.new(permitted_params)
      end

      sig { returns(PersonService) }
      def person_service
        @person_service = T.let(@person_service, T.nilable(PersonService))
        @person_service ||= ServiceFactory.person_service
      end
    end
  end
end
