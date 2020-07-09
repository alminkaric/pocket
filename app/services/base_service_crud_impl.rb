# typed: strict
# frozen_string_literal: true

class BaseServiceCrudImpl
  extend T::Sig
  include Loggers
  include ICrud

  sig { params(klass: T.class_of(ApplicationRecord), validator: T.nilable(IServiceValidator)).void }
  def initialize(klass, validator = nil)
    @klass = klass
    @validator = validator
  end

  sig { override.params(id: Integer).returns(T.untyped) }
  def get(id)
    debug_logger("Fetching a single #{@klass}, with id=#{id}")
    result = @klass.find(id)
    debug_logger("Found #{@klass}=#{result.attributes}")
    result
  end

  sig { override.params(args: T::Hash[Symbol, T.untyped]).returns(T::Array[ApplicationRecord]) }
  def find_by(args)
    debug_logger("Going to search #{@klass} with #{args}")
    result = @klass.where(args)
    debug_logger("Found #{result}")
    result.to_a
  end

  sig { override.returns(T.untyped) }
  def load_all
    debug_logger("Fetching all from #{@klass}")
    result = @klass.all
    debug_logger("Found #{result.size} #{@klass} elements")
    result.to_a
  end

  sig { override.params(record: ApplicationRecord).returns(T.untyped) }
  def update(record)
    if @validator
      debug_logger("Going to validate #{record} with #{@validator}")
      @validator.validate(record)
    end
    original_record = get(record.id)
    debug_logger("Going to update #{@klass}=#{original_record.attributes}")
    debug_logger("with the new data #{@klass}=#{record.attributes}")
    record.save
    debug_logger("#{record.attributes} updated succesfully!")
    record
  end

  sig { override.params(args: T::Hash[Symbol, T.untyped]).returns(ApplicationRecord) }
  def create(args)
    debug_logger("Going to create a new entry in database #{@klass}=#{args}")
    record = @klass.new(args)
    if @validator
      debug_logger("Going to validate #{record} with #{@validator}")
      @validator.validate(record)
    end
    record.save
    debug_logger("#{record.attributes} created succesfully!")
    record
  end

  sig { override.params(model: ApplicationRecord).void }
  def delete(model)
    debug_logger("Going to delete entry #{model.class}=#{model.attributes} from database")
    model.destroy
  end
end
