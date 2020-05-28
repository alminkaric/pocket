# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RoleModelValidator do
  # @!method role_validator
  #   @return [RoleModelValidator]
  subject { ValidatorFactory.get_validator(RoleModelValidator) }

  describe 'valid? method' do
    it 'returns true when role is valid' do
      role = Role.new(name: RoleTestData::NAME)
      subject.init(role)
      expect(subject.valid?).to be true
    end

    it 'returns false when role name is blank' do
      role = Role.new(name: '')
      subject.init(role)
      expect(subject.valid?).to be false
    end

    it 'returns false when role name is too short' do
      role = Role.new(name: 'rl')
      subject.init(role)
      expect(subject.valid?).to be false
    end

    it 'returns false when role name is not unique' do
      name = RoleTestData::NAME
      RoleTestData.get_or_create_role(name)
      role = Role.new(name: name)

      subject.init(role)
      expect(subject.valid?).to be false
    end
  end
end
