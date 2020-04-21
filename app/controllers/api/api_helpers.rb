# frozen_string_literal: true

# TODO: add doc
module Api
  module ApiHelpers
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
      if end_index > start_index
        output = collection.slice(start_index, end_index - start_index)
      end
      render json: output
    end

    def render_single_object(object)
      render json: object
    end
  end
end
