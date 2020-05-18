# typed: true
# frozen_string_literal: true

class PersonService < ApplicationService
  attr_reader :client_service

  def initialize
    @client_service = ClientService.new
  end

  sig { params(id: Integer).returns(Person) }
  def get(id)
    super(id)
  end

  ##
  # TODO: Add documentation
  # @param email[string] Email of the user
  # @return [Person]
  #
  sig do
    params(
      args: { first_name: String, last_name: String, email: String, password: String, client_id: Integer }
    )
      .returns(Person)
  end
  def create(args)
    person = build_person_with_user(args)
    puts "Creating person with params=#{args}"
    raise ArgumentError, 'User must be set' if person.user.nil?
    raise ArgumentError, 'Client must be set' if person.client_id.nil?

    save(person)
    puts "New person created person=#{person}"
    person
  end

  # TODO: add doc
  # @return [Person]
  def update(params)
    # @type [Person]
    person = get(params[:id])

    person.first_name = params[:first_name]
    person.last_name = params[:last_name]
    person.client_id = params[:client_id]
    person.employee_id = params[:employee_id]

    save(person)
  end

  protected

  def klass
    Person
  end

  private

  sig do
    params(
      first_name: String,
      last_name: String,
      email: String,
      password: String,
      client_id: Integer
    ).returns(Person)
  end
  def build_person_with_user(first_name:, last_name:, email:, password:, client_id:)
    user = User.new
    user.email = email
    user.password = password
    person = Person.new
    person.first_name = first_name
    person.last_name = last_name
    person.client_id = client_id
    person.user = user
    person
  end
end
