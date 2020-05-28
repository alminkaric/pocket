# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PermissionModelValidator do
  # @!method role_validator
  #   @return [PermissionValidator]
  subject { ValidatorFactory.get_validator(described_class) }

  describe 'valid? method' do
    it 'returns true when permission is valid' do
      permission = PermissionTestData.get_or_build
      subject.init(permission)
      expect(subject.valid?).to be true
    end

    it 'returns false when permission already exists' do
      original_permission = PermissionTestData.get_or_create
      new_permission = Permission.new(original_permission.attributes)
      new_permission.id = nil
      subject.init(new_permission)
      expect(subject.valid?).to be false
    end

    context 'when invalid class_name' do
      it 'raises error for nil' do
        permission = PermissionTestData.get_or_build
        permission.class_name = nil
        subject.init(permission)
        expect { subject.valid? }.to raise_error TypeError
      end

      it 'returns false for blank' do
        permission = PermissionTestData.get_or_build
        permission.class_name = ''
        subject.init(permission)
        expect(subject.valid?).to be false
      end

      it 'returns false for non-existing class' do
        permission = PermissionTestData.get_or_build
        permission.class_name = 'SomeRandomClassName'
        subject.init(permission)
        expect(subject.valid?).to be false
      end
    end

    context 'when invalid method_name' do
      it 'returns false for blank' do
        permission = PermissionTestData.get_or_build
        permission.method_name = ''
        subject.init(permission)
        expect(subject.valid?).to be false
      end
    end

    context 'when invalid holder' do
      it 'returns false for wrong class name' do
        permission = PermissionTestData.get_or_build
        permission.holder_id = 1
        permission.holder_type = 'WrongClass'
        subject.init(permission)
        expect(subject.valid?).to be false
      end

      it 'returns false for non-existing record' do
        permission = PermissionTestData.get_or_build
        permission.holder_id = 123
        permission.holder_type = User
        subject.init(permission)
        expect(subject.valid?).to be false
      end

      it 'raises error for missing holder_id' do
        permission = PermissionTestData.get_or_build
        permission.holder_id = nil
        permission.holder_type = User
        subject.init(permission)
        expect { subject.valid? }.to raise_error TypeError
      end

      it 'returns false for missing holder_type class' do
        permission = PermissionTestData.get_or_build
        permission.holder_id = 1
        permission.holder_type = nil
        subject.init(permission)
        expect(subject.valid?).to be false
      end
    end
  end
end
