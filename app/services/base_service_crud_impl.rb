# typed: strict
# frozen_string_literal: true

class BaseServiceCrudImpl
  extend T::Sig
  include Loggers
  include IService

  sig { params(klass: T.class_of(ApplicationRecord)).void }
  def initialize(klass)
    @klass = klass
  end

  sig { override.params(id: Integer).returns(T.untyped) }
  def get(id)
    debug_logger("Fetching a single #{@klass}, with id=#{id}")
    result = @klass.find(id)
    debug_logger("Found #{@klass}=#{result.attributes}")
    result
  end

  sig { override.returns(T.untyped) }
  def load_all
    debug_logger("Fetching all from #{@klass}")
    result = @klass.all
    debug_logger("Found #{result.size} #{@klass} elements")
    result.to_a
  end

  sig { override.params(model: ApplicationRecord).returns(T.untyped) }
  def save(model)
    if model.persisted?
      original_model = get(model.id)
      debug_logger("Going to update #{@klass}=#{original_model.attributes}")
      debug_logger("with the new data #{@klass}=#{model.attributes}")
    else
      debug_logger("Going to create a new entry in database #{@klass}=#{model.attributes}")
    end
    model.save
    debug_logger("#{model.attributes} saved succesfully!")
    model
  end

  sig { override.params(model: ApplicationRecord).void }
  def delete(model)
    debug_logger("Going to delete entry #{model.class}=#{model.attributes} from database")
    model.destroy
  end
end
