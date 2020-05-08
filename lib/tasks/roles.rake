# frozen_string_literal: true

namespace :roles do
  desc "Creates default roles, such as 'Developer' and 'Admin'"
  task create_default_roles: :environment do
    default_roles = %w[Developer Admin]
    roles_table_empty = Role.all.empty?

    if roles_table_empty
      default_roles.each do |role_name|
        puts "Creating #{role_name} role"
        role = Role.create(name: role_name)
        puts "Created role #{role.name} with id=#{role.id}"
      end
    end
  end
end
