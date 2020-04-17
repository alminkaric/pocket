class ClientService
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