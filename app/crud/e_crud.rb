# typed: strict
# frozen_string_literal: true

class ::ECrud < T::Enum
  enums do
    GET = new
    LOAD_ALL = new
    FIND = new
    CREATE = new
    UPDATE = new
    DELETE = new
  end
end
