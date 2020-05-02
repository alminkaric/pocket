# frozen_string_literal: true

# TODO: Add doc
class RoleService < ApplicationService
  def find_by_name(name)
    klass.find_by(name: name)
  end

  def assign_role_to_user(role:, user:)
    RoleAssignment.create(role: role, user: user)
  end

  protected

  def klass
    Role
  end
end
