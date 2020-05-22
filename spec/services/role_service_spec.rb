# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RoleService do
  # @!subject
  #   @return [RoleService]
  subject do
    ServiceFactory.role_service(UserTestData.get_or_create_admin_user)
  end

  describe 'save method' do
    it 'saves a role' do
      role = RoleTestData.get_or_build_role
      subject.save(role)
      expect(role.persisted?).to be true
    end

    context 'when regular user' do
      subject { ServiceFactory.role_service(UserTestData.get_or_create_user) }

      it "doesn't save a role" do
        role = RoleTestData.get_or_build_role
        expect { subject.save(role) }.to raise_exception PermissionError
      end

      it "doesn't update existing role" do
        role_name = 'some test role'
        role = RoleTestData.get_or_create_role(role_name)
        role.name = 'New role name'
        expect { subject.save(role) }.to raise_exception PermissionError
        role = subject.find_by_name(role_name)
        expect(role.name).to match role_name
      end
    end

    context 'when current_user is nil' do
      subject { ServiceFactory.role_service }

      it "doesn't save a role" do
        role = RoleTestData.get_or_build_role
        expect { subject.save(role) }.to raise_exception PermissionError
      end
    end
  end

  describe 'find_by_name method' do
    it 'returns role' do
      role_name = RoleTestData::NAME
      role = RoleTestData.get_or_create_role(role_name)
      founded_role = subject.find_by_name(role_name)
      expect(founded_role).to match role
    end
  end

  describe 'find_or_create method' do
    it 'creates new role for admin user' do
      role_name = 'some random role name'
      role = subject.find_or_create(role_name)
      expect(role.persisted?).to be true
    end

    it 'retrieves existing role' do
      role = RoleTestData.get_or_create_role
      founded_role = subject.find_or_create(RoleTestData::NAME)
      expect(founded_role).to match role
    end

    context 'when regular user' do
      subject { ServiceFactory.role_service(UserTestData.get_or_create_user) }

      it "doesn't create role" do
        expect { subject.find_or_create(RoleTestData::NAME) }.to raise_exception PermissionError
      end
    end
  end

  describe 'user_role? method' do
    it 'returns true when checking admin role for admin user' do
      has_admin_role = subject.user_role?(
        user: UserTestData.get_or_create_admin_user,
        role: Role.admin
      )
      expect(has_admin_role).to be true
    end

    it 'returns false when checking admin role for regular user' do
      has_admin_role = subject.user_role?(
        user: UserTestData.get_or_create_user,
        role: Role.admin
      )
      expect(has_admin_role).to be false
    end

    it 'returns false when checking non-saved role for user' do
      has_admin_role = subject.user_role?(
        user: UserTestData.get_or_create_user,
        role: Role.new(name: RoleTestData::NAME)
      )
      expect(has_admin_role).to be false
    end
  end

  describe 'assign_role_to_user method' do
    it 'assigns user to role' do
      user = UserTestData.get_or_create_user
      subject.assign_role_to_user(role: Role.admin, user: user)

      has_admin_role = subject.user_role?(
        user: user,
        role: Role.admin
      )
      expect(has_admin_role).to be true
    end

    context 'when regular user' do
      subject { ServiceFactory.role_service(UserTestData.get_or_create_user) }

      it "doesn't assing user to role" do
        user = UserTestData.get_or_create_user('some-random@user.com')
        expect do
          subject.assign_role_to_user(role: Role.admin, user: user)
        end.to raise_exception PermissionError
      end
    end

    context 'when current_user is nil' do
      subject { ServiceFactory.role_service }
      it "doesn't assing user to role" do
        user = nil
        expect do
          subject.assign_role_to_user(role: Role.admin, user: user)
        end.to raise_exception TypeError
      end
    end
  end
end
