# typed: strict
# frozen_string_literal: true

module IServiceFactory
  extend T::Sig
  extend T::Helpers
  interface!

  sig { abstract.params(type: ECrud).returns(IService) }
  def make_service(type); end
end
