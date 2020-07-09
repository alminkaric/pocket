# typed: strict
# frozen_string_literal: true

module TempUserService
  class ServiceFactory
    extend T::Sig
    include IServiceFactory

    sig { params(current_user: T.nilable(User)).void }
    def initialize(current_user = nil)
      @current_user = current_user
    end

    sig { override.params(service_type: ECrud).returns(IService) }
    def make_service(service_type)
      service = available_services[service_type]
      return service if service

      raise NotImplementedError, "#{service_type} in #{TempUserService} not yet implemented"
    end

    private

    sig { returns(T::Hash[ECrud, IService]) }
    def available_services
      {
        ECrud::GET => get_service,
        ECrud::LOAD_ALL => LoadAllUserService.new(crud),
        ECrud::FIND => FindByUserService.new(crud),
        ECrud::CREATE => create_service,
        ECrud::UPDATE => update_service,
        ECrud::DELETE => delete_service
      }
    end

    sig { returns(TempUserService::GetUserService) }
    def get_service
      GetUserService.new(crud, permission_service(GetUserService), T.must(@current_user))
    end

    sig { returns(TempUserService::UpdateUserService) }
    def update_service
      class_name = T.must(UpdateUserService.name)
      permission_service = PermissionService.new(class_name: class_name, current_user: @current_user)
      params = {
        crud: crud,
        permission_service: permission_service
      }
      UpdateUserService.new(params)
    end

    sig { returns(TempUserService::CreateUserService) }
    def create_service
      class_name = T.must(CreateUserService.name)
      permission_service = PermissionService.new(class_name: class_name, current_user: @current_user)
      params = {
        crud: crud,
        permission_service: permission_service
      }
      CreateUserService.new(params)
    end

    sig { returns(TempUserService::DeleteUserService) }
    def delete_service
      params = {
        crud: crud,
        permission_service: permission_service(DeleteUserService)
      }
      DeleteUserService.new(params)
    end

    sig { returns(ICrud) }
    def crud
      BaseServiceCrudImpl.new(User, validator)
    end

    sig { returns(IServiceValidator) }
    def validator
      user_validator = ValidatorFactory.get_validator(UserModelValidator)
      BaseServiceValidatorImpl.new(user_validator)
    end

    sig { params(klass: Class).returns(PermissionService) }
    def permission_service(klass)
      class_name = T.must(klass.name)
      PermissionService.new(class_name: class_name, current_user: @current_user)
    end
  end
end
