# typed: strict
# frozen_string_literal: true

module IService
  extend T::Sig
  extend T::Helpers
  interface!

  sig { abstract.params(id: Integer).returns(ApplicationRecord) }
  def get(id); end

  sig { abstract.returns(T::Array[ApplicationRecord]) }
  def load_all; end

  sig { abstract.params(record: T.untyped).returns(ApplicationRecord) }
  def save(record); end

  sig { abstract.params(record: T.untyped).void }
  def delete(record); end
end
