# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserService do
  # @!method subject
  #   @return [UserService]
  subject { ServiceFactory.user_service(User.admin) }

  describe 'create method' do
    it 'creates a new user' do
      user = subject.create(email: UserTestData::EMAIL, password: UserTestData::PASSWORD)
      expect(user.persisted?).to be true
    end

    it "doesn't a new user with missing email" do
      expect { subject.create(email: nil, password: UserTestData::PASSWORD) }.to raise_error TypeError
    end

    it "doesn't a new user with missing password" do
      expect { subject.create(email: UserTestData::EMAIL, password: nil) }.to raise_error TypeError
    end
  end

  describe 'get method' do
    it 'returns user' do
      user = UserTestData.get_or_create_user
      founded_user = subject.get(user.id)
      expect(user).to match founded_user
    end

    it 'returns admin user' do
      admin = UserTestData.get_or_create_admin_user
      founded_admin = subject.get(admin.id)
      expect(admin).to match founded_admin
    end
  end

  describe 'create_admin_user method' do
    it 'creates admin user' do
      new_admin_user = subject.create_admin_user(email: UserTestData::EMAIL, password: UserTestData::PASSWORD)
      expect(new_admin_user.persisted?).to be true
    end

    context 'when regular user' do
      subject { ServiceFactory.user_service(UserTestData.get_or_create_user) }

      it "doesn't create admin user" do
        expect do
          subject.create_admin_user(email: UserTestData::EMAIL, password: UserTestData::PASSWORD)
        end.to raise_exception PermissionError
      end
    end
  end

  describe 'find_user_by_email method' do
    it 'returns user' do
      email = UserTestData::EMAIL
      user = UserTestData.get_or_create_user(email)
      founded_user = subject.find_user_by_email(email)
      expect(founded_user).to match user
    end

    it "doesn't accept nil" do
      expect { subject.find_user_by_email(nil) }.to raise_error TypeError
    end
  end

  describe 'load_all method' do
    it 'returns all users' do
      founded_users = subject.load_all
      expect(founded_users).to match User.all
    end
  end

  describe 'save method' do
    it 'saves a new user' do
      user = User.new(email: 'newuser@email.com', password: 'testpass')
      user = subject.save(user)
      expect(user.persisted?).to be true
    end

    it 'updates existing user' do
      user = UserTestData.get_or_create_user
      user.password = '123456'
      expect { subject.save(user) }.not_to raise_error
    end

    context 'when regular user' do
      subject { ServiceFactory.user_service(UserTestData.get_or_create_user) }

      it "doesn't update other user" do
        user = UserTestData.get_or_create_user('new@user.test')
        user.email = 'new@email.com'
        expect { subject.save(user) }.to raise_exception PermissionError
      end

      it 'updates own user data' do
        email = 'new@email.com'
        user = UserTestData.get_or_create_user
        user.email = email
        user = subject.save(user)
        expect(user.email).to match email
      end
    end

    context 'when no current user' do
      subject { ServiceFactory.user_service(nil) }

      it "doesn't update other user" do
        user = UserTestData.get_or_create_user('new@user.test')
        user.email = 'new@email.com'
        expect { subject.save(user) }.to raise_exception PermissionError
      end
    end
  end

  describe 'delete method' do
    it 'deletes user' do
      user = UserTestData.get_or_create_user('some-random@user.test')
      user_id = user.id
      subject.delete(user)
      expect { subject.get(user_id) }.to raise_exception(ActiveRecord::RecordNotFound)
    end

    context 'when regular user' do
      subject { ServiceFactory.user_service(UserTestData.get_or_create_user) }

      it "doesn't delete other user" do
        user = UserTestData.get_or_create_user('new@user.test')
        expect { subject.delete(user) }.to raise_exception PermissionError
      end

      it 'deletes own user data' do
        user = UserTestData.get_or_create_user
        user_id = user.id
        subject.delete(user)
        expect { subject.get(user_id) }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end
end
