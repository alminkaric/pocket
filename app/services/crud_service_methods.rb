# frozen_string_literal: true

# Default CRUD implementation for the services.
# The following methods are included by including this module:
#
# - get(id)
# - load_all
# - save(model)
# - delete(model)
#
module CrudServiceMethods
  # Default implementation of get method for a model
  # @param id [Integer] unique identifier for the model
  def get(id)
    klass.find(id)
  end

  def load_all
    klass.all
  end

  def save(model)
    model.save
  end

  def delete(model)
    model.destroy
  end

  protected

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
