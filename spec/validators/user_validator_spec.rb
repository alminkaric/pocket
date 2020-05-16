# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserValidator do
  # @!method validator
  #   @return [UserValidator]
  let(:validator) { UserValidator.new }

  describe 'validate method' do
    it 'returns false when email is not present' do
      user = User.new
      expect(validator.validate(user)).to be false
    end

    it 'returns false when password is blank' do
      user = User.new(email: UserTestData::EMAIL, password: '')
      expect(validator.validate(user)).to be false
    end

    it 'returns false when password is less than 6 chars' do
      user = User.new(email: UserTestData::EMAIL, password: '1234')
      expect(validator.validate(user)).to be false
    end

    it 'returns false when email format is wrong' do
      user = User.new(password: UserTestData::PASSWORD)
      user.email = 'someinvalidemail'
      expect(validator.validate(user)).to be false

      user.email = 'stillnot@@@@validemail'
      expect(validator.validate(user)).to be false

      user.email = '@at.com'
      expect(validator.validate(user)).to be false
    end

    it 'returns true email and password are set' do
      user = User.new(email: UserTestData::EMAIL, password: UserTestData::PASSWORD)
      expect(validator.validate(user)).to be true
    end
  end

  describe 'errors method' do
    it 'returns some error messages when validation fail' do
      user = User.new(password: UserTestData::PASSWORD)
      user.email = 'someinvalidemail'
      validator.validate(user)
      expect(validator.errors.messages.size).to be > 0
    end

    it 'returns nil when object is valid' do
      user = User.new(email: UserTestData::EMAIL, password: UserTestData::PASSWORD)
      validator.validate(user)
      expect(validator.errors.messages.size).to be 0
    end
  end
end
