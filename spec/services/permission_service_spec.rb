# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PermissionService do
  # @!method user_test_data
  #   @return [UserTestData]
  let(:user_test_data) { UserTestData.new }

  # @!method permission_service_with_admin
  #   @return [PermissionService]
  let(:permission_service_with_admin) do
    PermissionService.new(current_user: user_test_data.admin_user, class_to_check: PermissionService)
  end

  # @!method permission_service_with_normal_user
  #   @return [PermissionService]
  let(:permission_service_with_normal_user) do
    PermissionService.new(current_user: user_test_data.normal_user, class_to_check: PermissionService)
  end

  describe 'check_user_permission_for method' do
    let(:method) { 'check_user_permission_for' }

    it "raises #{PermissionError.name} when user doesn't have permission" do
      Permission.create(
        class_name: described_class.name,
        method_name: method,
        holder: Role.admin
      )
      expect { permission_service_with_normal_user.check_user_permission_for(method) }.to raise_error PermissionError
    end

    it "raises #{PermissionError.name} when current_user is nil" do
      permission_service = PermissionService.new(
        class_to_check: described_class,
        current_user: nil
      )
      expect { permission_service.check_user_permission_for(method) }.to raise_error PermissionError
    end

    it "doesn't raise #{PermissionError.name} when user has a permission" do
      Permission.create(
        class_name: described_class.name,
        method_name: method,
        holder: Role.admin
      )
      expect { permission_service_with_admin.check_user_permission_for(method) }.not_to raise_error
    end

    it "raises #{ArgumentError.name} when method_name is blank" do
      expect { permission_service_with_admin.check_user_permission_for(nil) }.to raise_error ArgumentError
      expect { permission_service_with_admin.check_user_permission_for('') }.to raise_error ArgumentError
    end
  end

  describe 'save method' do
    let(:permission) do
      permission = Permission.new
      permission.class_name = PermissionService.name
      permission.method_name = 'test_method'
      permission.holder = Role.admin
      permission
    end

    it 'saves a permission if current user is admin' do
      permission_service_with_admin.save(permission)
      expect(permission.persisted?).to be true
    end

    it "doesn't save a permission if current user doesn't have permission" do
      expect { permission_service_with_normal_user.save(permission) }.to raise_error PermissionError
    end

    it "doesn't save a permission if current user nil" do
      permission_service = PermissionService.new(class_to_check: described_class)
      expect { permission_service.save(permission) }.to raise_error PermissionError
    end
  end

  describe 'delete method' do
    let(:permission) do
      permission = Permission.new
      permission.class_name = PermissionService.name
      permission.method_name = 'test_method'
      permission.holder = Role.admin
      permission.save
      permission
    end

    it 'deletes a permission if current user is admin' do
      permission_service_with_admin.delete(permission)
      expect { permission_service_with_admin.get(permission.id) }.to raise_error ActiveRecord::RecordNotFound
    end

    it "doesn't delete a permission if current user is normal user" do
      expect { permission_service_with_normal_user.delete(permission) }.to raise_error PermissionError
    end
  end
end
