# typed: false
# frozen_string_literal: true

# TODO: add doc
module Api
  module JsonRenderHelper
    # TODO: add doc
    # @param collection [ActiveRecord::Collection]
    # @param _start
    # @param _end
    def render_json(object)
      response.set_header('X-Total-Count', object.try(:size))
      return render_collection(object) if object.respond_to?('each')

      render_single_object(object)
    end

    private

    def render_collection(collection)
      start_index = params[:_start].to_i
      end_index = params[:_end].to_i
      output = collection
      output = collection.slice(start_index, end_index - start_index) if end_index > start_index
      render json: output
    end

    def render_single_object(object)
      render json: object
    end
  end
end
