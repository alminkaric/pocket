# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UserService' do
  let(:admin_user) do
    Tools::UserFakeGenerator.get_or_create_admin_user('adminuser@test.com')
  end
  let(:normal_user) do
    Tools::UserFakeGenerator.get_or_create_user('normaluser@test.com')
  end
  let(:user_service) { UserService.new }
  let(:email) { 'jon.snow@got.com' }
  let(:password) { 'testpass123' }

  describe 'create method' do
    it 'creates a new user without current user' do
      user = user_service.create(email: email, password: password)

      expect(user.persisted?).to be true
    end

    it 'creates a new user with admin user' do
      user_service = UserService.new(admin_user)
      user = user_service.create(email: email, password: password)

      expect(user.persisted?).to be true
    end

    it 'does not create new user with normal user' do
      user_service = UserService.new(normal_user)
      user = user_service.create(email: email, password: password)

      expect(user).to be nil
    end
  end

  describe 'get method' do
    it "doesn't return user without current user" do
      admin_id = admin_user.id
      user = user_service.get(admin_id)
      expect(user).to be nil
    end

    it "doesn't return user for other current user" do
      user_service = UserService.new(normal_user)
      admin_id = admin_user.id
      user = user_service.get(admin_id)
      expect(user).to be nil
    end

    it 'returns user for current user' do
      user_service = UserService.new(normal_user)
      user_id = normal_user.id
      user = user_service.get(user_id)
      expect(user.id).to be user_id
    end
  end
end
