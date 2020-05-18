# typed: strict
# frozen_string_literal: true

##
# CRUD method for Client model
class ClientService < ApplicationService
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
  sig { params(ids: T::Array[Integer]).returns(Client::ActiveRecord_Associations_CollectionProxy) }
  def find_by_ids_or_all(*ids)
    all_ids_integer = ids.all? { |i| i.is_a?(Integer) }
    return T.cast(Client.where(ids: ids), Client::ActiveRecord_Associations_CollectionProxy) if all_ids_integer

    load_all
  end

  protected

  sig { returns(T.class_of(ApplicationRecord)) }
  def klass
    Client
  end
end
