class PersonService
  def build_person(params)
    person = Person.new
    person.first_name = params[:first_name]
    person.last_name = params[:last_name]
    person.client = params[:client]
    person.user = params[:user]
    person
  end

  def build_person_with_user(params)
    user = User.new
    user.email = params[:email]
    user.password = params[:password]
    person = Person.new
    person.first_name = params[:first_name]
    person.last_name = params[:last_name]
    person.client = params[:client]
    person.user = user
    person
  end

  ##
  # TODO: Add documentation
  #
  def create_person(params)
    person = build_person_with_user(params)
    puts "Creating person with params=#{params}"
    raise ArgumentError.new('User must be set') if person.user.nil?
    raise ArgumentError.new('Client must be set') if person.client.nil?

    save(person)
    puts "New person created person=#{person}"
    person
  end

  def save(person)
    person.save
  end
end