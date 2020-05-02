# frozen_string_literal: true

class UserService < ApplicationService
  def initialize(current_user = nil)
    # @type [User]
    @current_user = current_user
  end

  def get(id)
    return nil if @current_user.blank?

    current_user_id = @current_user.id
    return nil if current_user_id != id

    super(id)
  end

  # @return [User]
  def find_user_by_email(email)
    User.find_by(email: email)
  end

  # @return [User]
  def create(email:, password:)
    user = User.new
    user.email = email
    user.password = password
    save(user)
  end

  protected

  def klass
    User
  end
end
