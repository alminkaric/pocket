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

    it 'returns true when permission already exists' do
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
  end
end
