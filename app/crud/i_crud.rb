# typed: strict
# frozen_string_literal: true

module ICrud
  extend T::Sig
  extend T::Helpers
  interface!

  sig { abstract.params(id: Integer).returns(Object) }
  def get(id); end

  sig { abstract.returns(T::Array[Object]) }
  def load_all; end

  sig { abstract.params(args: T::Hash[Symbol, T.untyped]).returns(T::Array[Object]) }
  def find_by(args); end

  sig { abstract.params(args: T::Hash[Symbol, T.untyped]).returns(Object) }
  def create(args); end

  sig { abstract.params(record: T.untyped).returns(Object) }
  def update(record); end

  sig { abstract.params(record: T.untyped).void }
  def delete(record); end
end
