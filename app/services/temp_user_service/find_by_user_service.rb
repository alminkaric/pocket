# typed: strict
# frozen_string_literal: true

module TempUserService
  class FindByUserService
    extend T::Sig
    include IService

    sig { params(crud: ICrud).void }
    def initialize(crud)
      @crud = crud
    end

    sig { override.params(args: { email: String }).returns(T::Array[User]) }
    def call(args)
      T.cast(@crud.find_by(args), T::Array[User])
    end
  end
end
