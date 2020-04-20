# frozen_string_literal: true

##
# CRUD method for Client model
class ClientService
  # @param id [Integer]
  def get(id)
    Client.find(id)
  end

  def load_all
    Client.all
  end

  ##
  # Builds new instance of client based on the following params
  # @param name [String]
  # @param description [String]
  # @return [Client]
  def build(params)
    client = Client.new
    client.name = params[:name]
    client.description = params[:description]
    client
  end

  def build_client(params)
    client = Client.new
    client.name = params[:name]
    client.description = params[:description]
    client
  end

  def create_client(params)
    puts "Building client with params=#{params}"
    client = build_client(params)
    save(client)
    puts "New client=#{client} created"
    client
  end

  def all_clients
    clients = Client.all
    puts "Loaded #{clients.size} clients"
    clients
  end

  def save(client)
    client.save
  end
end
