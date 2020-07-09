# typed: strict
# frozen_string_literal: true

module TempUserService
  class LoadAllUserService
    extend T::Sig
    include IService

    sig { params(crud: ICrud).void }
    def initialize(crud)
      @crud = crud
    end

    sig { override.params(_args: T.untyped).returns(T::Array[User]) }
    def call(_args = nil)
      T.cast(@crud.load_all.to_a, T::Array[User])
    end
  end
end
