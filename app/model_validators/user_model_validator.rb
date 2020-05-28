# typed: strict
# frozen_string_literal: true

class UserModelValidator
  extend T::Sig
  include IModelValidator

  sig { void }
  def initialize
    @user = T.let(User.new, User)
  end

  sig { override.returns(T.class_of(ApplicationRecord)) }
  def model
    User
  end

  sig { override.params(user: User).void }
  def init(user)
    @user = user
  end

  sig { override.returns(T::Boolean) }
  def valid?
    @user.valid?
  end

  sig { override.returns(ActiveModel::Errors) }
  def errors
    @user.errors
  end
end
