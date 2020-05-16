# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RoleValidator do
  # @!method role_validator
  #   @return [RoleValidator]
  subject { described_class.new }

  describe 'validate method' do
    it 'returns true when role is valid' do
      role = Role.new(name: RoleTestData::NAME)
      expect(subject.validate(role)).to be true
    end

    it 'returns false when role name is blank' do
      role = Role.new(name: '')
      expect(subject.validate(role)).to be false

      role.name = nil
      expect(subject.validate(role)).to be false
    end

    it 'returns false when role name is not unique' do
      name = RoleTestData::NAME
      RoleTestData.get_or_create_role(name)
      role = Role.new(name: name)

      expect(subject.validate(role)).to be false
    end
  end
end
