# typed: strict
# frozen_string_literal: true

class User < ApplicationRecord
  extend T::Sig
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :person

  has_many :role_assignments

  has_many :roles, through: :role_assignments

  sig { returns(User) }
  def self.admin_user
    # tried as constant but didn't work in test env
    T.must(User.find_by(email: 'admin@pocket.com'))
  end
end
