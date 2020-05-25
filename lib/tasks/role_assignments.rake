# frozen_string_literal: true

namespace :role_assignments do
  desc 'Adds admin role to admin user'
  task add_admin_user_role: :environment do
    role = Role.admin
    admin_user = User.admin
    admin_user = User.create(email: 'admin@pocket.com', password: 'defaultAdminPassword') unless admin_user.present?

    role_assignment = RoleAssignment.find_by(role: role, user: admin_user)

    RoleAssignment.create(role: role, user: admin_user) unless role_assignment.present?
  end
end
