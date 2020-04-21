# frozen_string_literal: true

class PersonService
  attr_reader :client_service

  include CrudServiceMethods

  def initialize
    @client_service = ClientService.new
  end

  ##
  # TODO: Add documentation
  # @param email[string] Email of the user
  #
  def create(params)
    person = build_person_with_user(params)
    puts "Creating person with params=#{params}"
    raise ArgumentError, 'User must be set' if person.user.nil?
    raise ArgumentError, 'Client must be set' if person.client_id.nil?

    save(person)
    puts "New person created person=#{person}"
    person
  end

  protected

  def klass
    Person
  end

  private

  def build_person_with_user(params)
    user = User.new
    user.email = params[:email]
    user.password = params[:password]
    person = Person.new
    person.first_name = params[:first_name]
    person.last_name = params[:last_name]
    person.client_id = params[:client_id]
    person.user = user
    person
  end
end
