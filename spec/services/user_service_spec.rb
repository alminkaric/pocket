# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UserService' do
  # @!method user_test_data
  #   @return [UserTestData]
  let(:user_test_data) { UserTestData.new }

  let(:admin_user) { user_test_data.admin_user }
  let(:normal_user) { user_test_data.normal_user }
  let(:user_service) { UserService.new }
  let(:email) { UserTestData::EMAIL }
  let(:password) { UserTestData::PASSWORD }

  describe 'create method' do
    it 'creates a new user without current user' do
      user = user_service.create(email: email, password: password)

      expect(user.persisted?).to be true
    end

    it 'creates a new user with admin user' do
      user_service = UserService.new(user_test_data.admin_user)
      user = user_service.create(email: email, password: password)

      expect(user.persisted?).to be true
    end
  end

  describe 'get method' do
    it 'returns user for current user' do
      user_service = UserService.new(normal_user)
      user_id = normal_user.id
      user = user_service.get(user_id)
      expect(user).to match normal_user
    end

    it 'returns user for other user' do
      user_service = UserService.new(normal_user)
      admin_user_id = admin_user.id
      user = user_service.get(admin_user_id)
      expect(user).to match admin_user
    end

    it 'returns user for admin user' do
      user_service = UserService.new(admin_user)
      user_id = normal_user.id
      user = user_service.get(user_id)
      expect(user).to match normal_user
    end
  end

  describe 'create_admin_user method' do
    it "doesn't create admin user without current user" do
      user_service = UserService.new
      expect { user_service.create_admin_user(email: email, password: password) }.to raise_exception PermissionError
    end

    it "doesn't create admin user for regular current user" do
      user_service = UserService.new(normal_user)
      expect { user_service.create_admin_user(email: email, password: password) }.to raise_exception PermissionError
    end

    it 'creates admin user if current_user is admin' do
      user_service = UserService.new(admin_user)
      new_admin_user = user_service.create_admin_user(email: email, password: password)
      expect(new_admin_user.persisted?).to be true
    end
  end

  describe 'find_user_by_email method' do
    it 'returns user if current user is admin' do
      user_service = UserService.new(admin_user)
      founded_user = user_service.find_user_by_email(normal_user.email)
      expect(founded_user).to match normal_user
    end

    it 'returns user for current user' do
      user_service = UserService.new(normal_user)
      founded_user = user_service.find_user_by_email(normal_user.email)
      expect(founded_user).to match normal_user
    end
  end

  describe 'load_all method' do
    it 'returns all users if current user is admin' do
      user_service = UserService.new(admin_user)
      founded_users = user_service.load_all
      expect(founded_users).to match User.all
    end

    it 'returns all users for normal user' do
      user_service = UserService.new(normal_user)
      founded_users = user_service.load_all
      expect(founded_users).to match User.all
    end
  end

  describe 'save method' do
    it 'saves a new user without current_user' do
      user = User.new(email: 'newuser@email.com', password: 'testpass')
      user = user_service.save(user)
      expect(user.persisted?).to be true
    end

    it "doesn't save user for other than current_user" do
      user_service = UserService.new(normal_user)
      admin_user.email = 'newadmin@email.com'
      expect { user_service.save(admin_user) }.to raise_exception PermissionError
    end

    it 'saves user if current user is admin' do
      user_service = UserService.new(admin_user)
      normal_user.email = 'newadmin@email.com'
      saved_user = user_service.save(normal_user)
      expect(saved_user).to match normal_user
    end
  end

  describe 'delete method' do
    it "doesn't delete user without current user" do
      expect { user_service.delete(normal_user) }.to raise_exception(PermissionError)
      founded_user = user_service.get(normal_user.id)
      expect(founded_user).to match normal_user
    end

    it "doesn't delete user itself" do
      user_service = UserService.new(normal_user)
      expect { user_service.delete(normal_user) }.to raise_exception(PermissionError)
      founded_user = user_service.get(normal_user.id)
      expect(founded_user).to match normal_user
    end

    it 'deletes user if current user is admin' do
      user_service = UserService.new(admin_user)
      user_service.delete(normal_user)
      expect { user_service.get(normal_user.id) }.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end
end
