# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
# @!attribute id
#   @return []
# @!attribute email
#   @return [String]
# @!attribute encrypted_password
#   @return [String]
# @!attribute remember_created_at
#   @return [Time]
# @!attribute reset_password_sent_at
#   @return [Time]
# @!attribute reset_password_token
#   @return [String]
# @!attribute created_at
#   @return [Time]
# @!attribute updated_at
#   @return [Time]
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # @!method person
  #   @return [Person]
  has_one :person

  # @!method role_assignments
  #   @return [Array<RoleAssignment>]
  has_many :role_assignments

  # @!method roles
  #   @return [Array<Role>]
  has_many :roles, through: :role_assignments

  def self.admin_user
    # tried as constant but didn't work in test env
    User.find_by(email: 'admin@pocket.com')
  end
end
