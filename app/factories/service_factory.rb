# typed: strict
# frozen_string_literal: true

class ServiceFactory
  extend T::Sig
  class << self
    extend T::Sig

    sig { params(module_const: Module, crud_type: ECrud, current_user: T.nilable(User)).returns(IService) }
    def get_service(module_const, crud_type, current_user = nil)
      service_factory_class = T.unsafe("#{module_const}::ServiceFactory".constantize)
      service_factory = T.let(service_factory_class.new(current_user), IServiceFactory)
      service_factory.make_service(crud_type)
    end

    sig { params(current_user: T.nilable(User)).returns(UserService) }
    def user_service(current_user = nil)
      permission_service = permission_service(UserService, current_user)
      role_service = role_service(current_user)
      user_validator = ValidatorFactory.get_validator(UserModelValidator)
      params = {
        crud: BaseServiceCrudImpl.new(User),
        permission_service: permission_service,
        role_service: role_service,
        validator: base_service_validator_impl(user_validator),
        current_user: current_user
      }
      UserService.new(params)
    end

    sig { returns(PersonService) }
    def person_service
      PersonService.new(client_service)
    end

    sig { returns(ClientService) }
    def client_service
      ClientService.new
    end

    sig { params(class_to_check: Class, current_user: T.nilable(User)).returns(PermissionService) }
    def permission_service(class_to_check, current_user = nil)
      class_name = T.must(class_to_check.name)
      PermissionService.new(class_name: class_name, current_user: current_user)
    end

    sig { params(current_user: T.nilable(User)).returns(RoleService) }
    def role_service(current_user = nil)
      RoleService.new(permission_service(RoleService, current_user))
    end

    private

    sig { params(klass: T.class_of(ApplicationRecord)).returns(ICrud) }
    def base_service_crud_impl(klass)
      BaseServiceCrudImpl.new(klass)
    end

    sig { params(validator: IValidator).returns(IServiceValidator) }
    def base_service_validator_impl(validator)
      BaseServiceValidatorImpl.new(validator)
    end
  end
end
