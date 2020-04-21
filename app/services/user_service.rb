# frozen_string_literal: true

class UserService
  include CrudServiceMethods

  protected

  def klass
    User
  end
end
