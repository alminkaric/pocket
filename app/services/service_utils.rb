# typed: strict
# frozen_string_literal: true

class ServiceUtils
  extend T::Sig
  class << self
    extend T::Sig
    include Loggers
    sig { params(id: Integer, klass: T.class_of(ApplicationRecord)).returns(T.untyped) }
    def get(id, klass)
      debug_logger("Fetching a single #{klass}, with id=#{id}")
      result = klass.find(id)
      debug_logger("Found #{klass}=#{result.attributes}")
      result
    end

    sig { params(klass: T.class_of(ApplicationRecord)).returns(T.untyped) }
    def load_all(klass)
      debug_logger("Fetching all from #{klass}")
      result = klass.all
      debug_logger("Found #{result.size} #{klass} elements")
      result.to_a
    end

    sig { params(model: ApplicationRecord, klass: T.class_of(ApplicationRecord)).returns(T.untyped) }
    def save(model, klass)
      if model.persisted?
        original_model = get(model.id, klass)
        debug_logger("Going to update #{klass}=#{original_model.attributes}")
        debug_logger("with the new data #{klass}=#{model.attributes}")
      else
        debug_logger("Going to create a new entry in database #{klass}=#{model.attributes}")
      end
      model.save
      debug_logger("#{model.attributes} saved succesfully!")
      model
    end

    sig { params(model: ApplicationRecord, klass: T.class_of(ApplicationRecord)).void }
    def delete(model, klass)
      debug_logger("Going to delete entry #{klass}=#{model.attributes} from database")
      model.destroy
    end

    sig { params(model: ApplicationRecord, validator: IValidator).void }
    def validate(model, validator)
      validator.init(model)
      raise ValidationError, validator.errors unless validator.valid?
    end
  end
end
