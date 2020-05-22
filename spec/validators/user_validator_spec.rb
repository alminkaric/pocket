# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserValidator do
  # @!method subject
  #   @return [UserValidator]
  subject { ValidatorFactory.get_validator(described_class) }

  describe 'valid? method' do
    it 'returns false when email is not present' do
      user = User.new
      subject.init(user)
      expect(subject.valid?).to be false
    end

    it 'returns false when password is blank' do
      user = User.new(email: UserTestData::EMAIL, password: '')
      subject.init(user)
      expect(subject.valid?).to be false
    end

    it 'returns false when password is less than 6 chars' do
      user = User.new(email: UserTestData::EMAIL, password: '1234')
      subject.init(user)
      expect(subject.valid?).to be false
    end

    it 'returns false when email format is wrong' do
      user = User.new(password: UserTestData::PASSWORD)
      user.email = 'someinvalidemail'
      subject.init(user)
      expect(subject.valid?).to be false

      user.email = 'stillnot@@@@validemail'
      subject.init(user)
      expect(subject.valid?).to be false

      user.email = '@at.com'
      subject.init(user)
      expect(subject.valid?).to be false
    end

    it 'returns true email and password are set' do
      user = User.new(email: UserTestData::EMAIL, password: UserTestData::PASSWORD)
      subject.init(user)
      expect(subject.valid?).to be true
    end
  end

  describe 'errors method' do
    it 'returns some error messages when validation fail' do
      user = User.new(password: UserTestData::PASSWORD)
      user.email = 'someinvalidemail'
      subject.init(user)
      expect(subject.valid?).to be false
      expect(subject.errors.messages.size).to be > 0
    end

    it 'returns nil when object is valid' do
      user = User.new(email: UserTestData::EMAIL, password: UserTestData::PASSWORD)
      subject.init(user)
      expect(subject.valid?).to be true
      expect(subject.errors.messages.size).to be 0
    end
  end
end
