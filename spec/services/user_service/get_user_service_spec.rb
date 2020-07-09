# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TempUserService::GetUserService do
  # @!method subject
  #   @return [IService]
  subject { ServiceFactory.get_service(TempUserService, ECrud::GET, UserTestData.get_or_create_admin_user) }

  describe 'call method' do
    it 'returns user' do
      user = UserTestData.get_or_create_user
      founded_user = subject.call(user.id)
      expect(user).to match founded_user
    end

    it 'returns admin user' do
      admin = UserTestData.get_or_create_admin_user
      founded_admin = subject.call(admin.id)
      expect(admin).to match founded_admin
    end

    context 'when regular current_usser is a regular user' do
      subject { ServiceFactory.get_service(TempUserService, ECrud::GET, UserTestData.get_or_create_user) }

      it 'returns user if own user' do
        user = UserTestData.get_or_create_user
        founded_user = subject.call(user.id)
        expect(user).to match founded_user
      end

      it "raises #{PermissionError} for other user" do
        admin = UserTestData.get_or_create_admin_user
        expect { subject.call(admin.id) }.to raise_error PermissionError
      end
    end
  end
end
