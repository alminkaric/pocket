# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'RoleService' do
  # @!method user_test_data
  #   @return [UserTestData]
  let(:user_test_data) { UserTestData.new }
  # @!method role_service
  #   @return [RoleService]
  let(:role_service) { RoleService.new }
  let(:role_name) { 'Test role' }
  let(:role) { Role.create(name: role_name) }

  describe 'save method' do
    it 'saves a role for admin user' do
      role_service = RoleService.new(user_test_data.admin_user)
      role = Role.new
      role.name = role_name
      role_service.save(role)
      expect(role.persisted?).to be true
    end

    it "doesn't save a role for normal user" do
      role_service = RoleService.new(user_test_data.normal_user)
      role = Role.new
      role.name = role_name
      expect { role_service.save(role) }.to raise_exception PermissionError
    end

    it "doesn't update existing role for normal user" do
      role_service = RoleService.new(user_test_data.normal_user)
      role.name = 'New role name'
      expect { role_service.save(role) }.to raise_exception PermissionError
      role = role_service.find_by_name(role_name)
      expect(role.name).to match role_name
    end

    it "doesn't save a role without current_user" do
      role = Role.new
      role.name = role_name
      expect { role_service.save(role) }.to raise_exception PermissionError
    end
  end

  describe 'find_by_name method' do
    it 'returns role for admin user' do
      role_service = RoleService.new(user_test_data.admin_user)
      role = Role.create(name: role_name)
      founded_role = role_service.find_by_name(role_name)
      expect(founded_role).to match role
    end

    it 'returns role for normal_user' do
      role_service = RoleService.new(user_test_data.normal_user)
      role = Role.create(name: role_name)
      founded_role = role_service.find_by_name(role_name)
      expect(founded_role).to match role
    end
  end

  describe 'find_or_create method' do
    it 'creates new role for admin user' do
      role_service = RoleService.new(user_test_data.admin_user)
      role = role_service.find_or_create(role_name)
      expect(role.persisted?).to be true
    end

    it 'retrieves existing role for admin user' do
      role_service = RoleService.new(user_test_data.admin_user)
      role = Role.create(name: role_name)
      founded_role = role_service.find_or_create(role_name)
      expect(founded_role).to match role
    end

    it "doesn't create role for normal user" do
      role_service = RoleService.new(user_test_data.normal_user)
      expect { role_service.find_or_create(role_name) }.to raise_exception PermissionError
    end
  end

  describe 'user_role? method' do
    it 'returns true when checking admin role for admin user' do
      has_admin_role = role_service.user_role?(
        user: user_test_data.admin_user,
        role: Role.admin
      )
      expect(has_admin_role).to be true
    end

    it 'returns false when checking admin role for normal user' do
      has_admin_role = role_service.user_role?(
        user: user_test_data.normal_user,
        role: Role.admin
      )
      expect(has_admin_role).to be false
    end

    it 'returns false when checking admin role for nil current user' do
      has_admin_role = role_service.user_role?(
        user: nil,
        role: Role.admin
      )
      expect(has_admin_role).to be false
    end

    it 'returns false when checking nil role for user' do
      has_admin_role = role_service.user_role?(
        user: user_test_data.normal_user,
        role: nil
      )
      expect(has_admin_role).to be false
    end
  end

  describe 'assign_role_to_user method' do
    it 'assigns user to role when current user is admin' do
      role_service = RoleService.new(user_test_data.admin_user)
      user = user_test_data.normal_user
      role_service.assign_role_to_user(role: Role.admin, user: user)

      has_admin_role = role_service.user_role?(
        user: user,
        role: Role.admin
      )
      expect(has_admin_role).to be true
    end

    it "doesn't assing user to role when current user is normal user" do
      role_service = RoleService.new(user_test_data.normal_user)
      user = user_test_data.normal_user
      expect do
        role_service.assign_role_to_user(role: Role.admin, user: user)
      end.to raise_exception PermissionError
    end

    it "doesn't assing user to role when current user is nil" do
      role_service = RoleService.new(user_test_data.normal_user)
      user = nil
      expect do
        role_service.assign_role_to_user(role: Role.admin, user: user)
      end.to raise_exception PermissionError
    end
  end
end