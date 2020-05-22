# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PermissionService do
  # @!method subject
  #   @return [PermissionService]
  subject do
    ServiceFactory.permission_service(described_class, UserTestData.get_or_create_admin_user)
  end
  let(:method) { raise NotImplementedError 'implement me' }

  describe 'check_user_permission_for method' do
    let(:method) { 'check_user_permission_for' }

    it "doesn't raise #{PermissionError.name} when user has a permission" do
      expect { subject.check_user_permission_for(method) }.not_to raise_error
    end

    it "raises #{ArgumentError.name} when method_name is blank" do
      expect { subject.check_user_permission_for('') }.to raise_error ArgumentError
    end

    context 'when current_user is nil' do
      subject { ServiceFactory.permission_service(described_class) }

      it "raises #{PermissionError.name}" do
        expect { subject.check_user_permission_for(method) }.to raise_error PermissionError
      end
    end

    context 'when regular user' do
      subject { ServiceFactory.permission_service(described_class, UserTestData.get_or_create_user) }

      it "raises #{PermissionError.name}" do
        expect { subject.check_user_permission_for(method) }.to raise_error PermissionError
      end
    end
  end

  describe 'save method' do
    let(:method) { 'save' }
    let(:permission) do
      permission = Permission.new
      permission.class_name = PermissionService.name
      permission.method_name = 'test_method'
      permission.holder = Role.admin
      permission
    end

    it 'saves a permission' do
      subject.save(permission)
      expect(permission.persisted?).to be true
    end

    context 'when regular user without permission' do
      subject { ServiceFactory.permission_service(described_class, UserTestData.get_or_create_user) }

      it "doesn't save a permission" do
        expect { subject.save(permission) }.to raise_error PermissionError
      end
    end

    context 'when current_user is nil' do
      subject { ServiceFactory.permission_service(described_class) }

      it "doesn't save a permission" do
        expect { subject.save(permission) }.to raise_error PermissionError
      end
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

    it 'deletes a permission' do
      permission_id = permission.id
      subject.delete(permission)
      expect { subject.get(permission_id) }.to raise_error ActiveRecord::RecordNotFound
    end

    context 'when current_user is nil' do
      subject { ServiceFactory.permission_service(described_class) }

      it "doesn't delete a permission if current user is normal user" do
        expect { subject.delete(permission) }.to raise_error PermissionError
      end
    end
  end
end
