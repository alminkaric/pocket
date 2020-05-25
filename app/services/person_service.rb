# typed: strict
# frozen_string_literal: true

class PersonService
  extend T::Sig
  include IService

  sig { params(client_service: ClientService).void }
  def initialize(client_service)
    @client_service = client_service
  end

  sig { override.params(id: Integer).returns(Person) }
  def get(id)
    ServiceUtils::Crud.get(id, Person)
  end

  sig { override.returns(T::Array[Person]) }
  def load_all
    ServiceUtils::Crud.load_all(Person)
  end

  sig { override.params(person: Person).returns(Person) }
  def save(person)
    ServiceUtils::Crud.save(person, Person)
  end

  sig { override.params(person: Person).void }
  def delete(person)
    ServiceUtils::Crud.delete(person)
  end
end
