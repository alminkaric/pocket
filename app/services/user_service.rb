# typed: strict
# frozen_string_literal: true

class UserService
  extend T::Sig
  include IService

  sig do
    params(
      crud: ICrud,
      permission_service: PermissionService,
      role_service: RoleService,
      validator: IServiceValidator,
      current_user: T.nilable(User)
    ).void
  end
  def initialize(crud:, permission_service:, role_service:, validator:, current_user: nil)
    @crud = crud
    @permission_service = permission_service
    @role_service = role_service
    @validator = validator
    @current_user = current_user
  end

  sig { params(id: Integer).returns(User) }
  def get(id)
    T.cast(@crud.get(id), User)
  end

  sig { returns(T::Array[User]) }
  def load_all
    T.cast(@crud.load_all, T::Array[User])
  end

  sig { params(email: String).returns(T.nilable(User)) }
  def find_user_by_email(email)
    User.find_by(email: email)
  end

  sig { params(email: String, password: String).returns(User) }
  def create(email:, password:)
    user = User.new
    user.email = email
    user.password = password
    save(user)
  end

  sig { params(email: String, password: String).returns(User) }
  def create_admin_user(email:, password:)
    @permission_service.check_user_permission_for('create_admin_user')

    user = create(email: email, password: password)
    @role_service.assign_role_to_user(role: Role.admin, user: user)
    user
  end

  sig { params(user: User).returns(User) }
  def save(user)
    @permission_service.check_user_permission_for('save') unless user.new_record? || own_user?(user)
    @validator.validate(user)

    T.cast(@crud.save(user), User)
  end

  sig { params(user: User).void }
  def delete(user)
    @permission_service.check_user_permission_for('delete') unless own_user?(user)

    @crud.delete(user)
  end

  private

  sig { params(user: User).returns(T::Boolean) }
  def own_user?(user)
    return false unless @current_user

    user == @current_user
  end
end
