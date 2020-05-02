# frozen_string_literal: true

# Default CRUD implementation for the services.
# The following methods are included by including this module:
#
# - get(id)
# - load_all
# - save(model)
# - delete(model)
#
class ApplicationService
  include Loggers
  # Default implementation of get method for a model
  # @param id [Integer] unique identifier for the model
  def get(id)
    debug_logger("Fetching a single #{klass}, with id=#{id}")
    result = klass.find(id)
    debug_logger("Found #{klass}=#{result.attributes}")
    result
  end

  # @return [Array]
  def load_all
    debug_logger("Fetching all from #{klass}")
    result = klass.all
    debug_logger("Found #{result.size} #{klass} elements")
    result
  end

  def save(model)
    if model.persisted?
      original_model = get(model.id)
      debug_logger("Going to update #{klass}=#{original_model.attributes}")
      debug_logger("with the new data #{klass}=#{model.attributes}")
    else
      debug_logger("Going to create a new entry in database #{klass}=#{model.attributes}")
    end
    model.save
    debug_logger("#{model.attributes} saved succesfully!")
    model
  end

  def delete(model)
    debug_logger("Going to delete entry #{klass}=#{model.attributes} from database")
    model.destroy
  end

  private

  # Represents the model class. This method must be
  # implemented by the service.

  # Example - basic usage:
  #
  #   class UserService
  #
  #     protected
  #
  #     def klass
  #       User
  #     end
  #   end
  #
  #
  def klass
    raise "The method 'klass' is not implemented.
    Please implement this method in the service"
  end
end
