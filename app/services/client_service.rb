# frozen_string_literal: true

##
# CRUD method for Client model
class ClientService
  include CrudServiceMethods

  ##
  # Creates new record of client based on the following params
  # @param name [String]
  # @param description [String]
  # @return [Client]
  def create(params)
    puts "Building client with params=#{params}"
    client = Client.new
    client.name = params[:name]
    client.description = params[:description]
    save(client)
    puts "New client=#{client} created"
    client
  end

  # TODO: Add doc
  def find_by_ids_or_all(*ids)
    all_ids_integer = ids.all? { |i| i.is_a?(Integer) }
    return Client.find(ids: ids) if all_ids_integer

    load_all
  end

  protected

  def klass
    Client
  end
end
