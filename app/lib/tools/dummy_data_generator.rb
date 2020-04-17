module Tools
  class DummyDataGenerator
    class << self
      def generate_clients
        15.times do
          name = Faker::Company.name
          description = Faker::Company.catch_phrase
          client_service.create_client(name: name, description: description)
        end
      end

      def generate_client_employees
        clients = client_service.all_clients
        clients.each do |client|
          number_of_employees = rand(5..15)
          number_of_employees.times do
            first_name = Faker::Name.first_name
            last_name = Faker::Name.last_name
            client_name_domain = client.name.gsub(' ', '-').downcase
            client_name_domain = client_name_domain.gsub(',', '')
            email = "#{first_name}.#{last_name}@#{client_name_domain}.com"
            password = Faker::Internet.password(min_length: 8)

            person_service.create_person(
              first_name: first_name,
              last_name: last_name,
              email: email,
              password: password,
              client: client
             )
          end
        end
      end

      private 

      def client_service
        @client_service ||= ClientService.new
      end

      def person_service
        @person_service ||= PersonService.new
      end
    end
  end
end