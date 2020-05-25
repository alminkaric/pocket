# typed: strict
# frozen_string_literal: true

##
# CRUD method for Client model
class ClientService
  extend T::Sig
  include IService

  sig { override.params(id: Integer).returns(Client) }
  def get(id)
    ServiceUtils::Crud.get(id, Client)
  end

  sig { override.returns(T::Array[Client]) }
  def load_all
    ServiceUtils::Crud.load_all(Client)
  end

  sig { override.params(client: Client).returns(Client) }
  def save(client)
    ServiceUtils::Crud.save(client, Client)
  end

  sig { override.params(client: Client).void }
  def delete(client)
    ServiceUtils::Crud.delete(client)
  end

  ##
  # Creates new record of client based on the following params
  # @param name [String]
  # @param description [String]
  # @return [Client]
  sig { params(name: String, description: T.nilable(String)).returns(Client) }
  def create(name:, description: nil)
    puts "Building client with name=#{name}, description=#{description}"
    client = Client.new
    client.name = name
    client.description = description
    save(client)
    puts "New client=#{client} created"
    client
  end

  # TODO: Add doc
  sig { params(ids: T::Array[Integer]).returns(T::Array[Client]) }
  def find_by_ids_or_all(*ids)
    all_ids_integer = ids.all? { |i| i.is_a?(Integer) }
    if all_ids_integer
      clients = Client.where(ids: ids)
      return clients.to_a
    end

    load_all
  end
end
