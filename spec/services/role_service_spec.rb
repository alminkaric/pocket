# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'RoleService' do
  # @!method user_test_data
  #   @return [UserTestData]
  let(:user_test_data) { UserTestData.new }
  # @!method role_service
  #   @return [RoleService]
  let(:role_service) { ServiceFactory.role_service }
  let(:role_service_with_admin) { ServiceFactory.role_service(user_test_data.admin_user) }
  let(:role_service_with_normal_user) { ServiceFactory.role_service(user_test_data.normal_user) }
  let(:role_name) { 'Test role' }
  let(:role) { Role.create(name: role_name) }

  describe 'save method' do
    it 'saves a role for admin user' do
      role = Role.new
      role.name = role_name
      role_service_with_admin.save(role)
      expect(role.persisted?).to be true
    end

    it "doesn't save a role for normal user" do
      role = Role.new
      role.name = role_name
      expect { role_service_with_normal_user.save(role) }.to raise_exception PermissionError
    end

    it "doesn't update existing role for normal user" do
      role.name = 'New role name'
      expect { role_service_with_normal_user.save(role) }.to raise_exception PermissionError
      role = role_service_with_normal_user.find_by_name(role_name)
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
      role = Role.create(name: role_name)
      founded_role = role_service_with_admin.find_by_name(role_name)
      expect(founded_role).to match role
    end

    it 'returns role for normal_user' do
      role = Role.create(name: role_name)
      founded_role = role_service_with_normal_user.find_by_name(role_name)
      expect(founded_role).to match role
    end
  end

  describe 'find_or_create method' do
    it 'creates new role for admin user' do
      role = role_service_with_admin.find_or_create(role_name)
      expect(role.persisted?).to be true
    end

    it 'retrieves existing role for admin user' do
      role = Role.create(name: role_name)
      founded_role = role_service_with_admin.find_or_create(role_name)
      expect(founded_role).to match role
    end

    it "doesn't create role for normal user" do
      expect { role_service_with_normal_user.find_or_create(role_name) }.to raise_exception PermissionError
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

    it 'returns false when checking non-saved role for user' do
      has_admin_role = role_service.user_role?(
        user: user_test_data.normal_user,
        role: Role.new(name: RoleTestData::NAME)
      )
      expect(has_admin_role).to be false
    end
  end

  describe 'assign_role_to_user method' do
    it 'assigns user to role when current user is admin' do
      user = user_test_data.normal_user
      role_service_with_admin.assign_role_to_user(role: Role.admin, user: user)

      has_admin_role = role_service_with_admin.user_role?(
        user: user,
        role: Role.admin
      )
      expect(has_admin_role).to be true
    end

    it "doesn't assing user to role when current user is normal user" do
      user = user_test_data.normal_user
      expect do
        role_service_with_normal_user.assign_role_to_user(role: Role.admin, user: user)
      end.to raise_exception PermissionError
    end

    it "doesn't assing user to role when current user is nil" do
      user = nil
      expect do
        role_service_with_normal_user.assign_role_to_user(role: Role.admin, user: user)
      end.to raise_exception PermissionError
    end
  end
end
