# typed: true
# frozen_string_literal: true

class RoleTestData
  NAME = 'Test Role'

  class << self
    def get_or_create_role(name = nil)
      name = NAME if name.blank?
      Role.find_or_create_by(name: name)
    end

    private

    def role_service
      @role_service ||= RoleService.new
    end
  end
end
