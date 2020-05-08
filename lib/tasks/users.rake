# frozen_string_literal: true

namespace :users do
  desc 'Creates admin user for this app'
  task create_admin_user: :environment do
    email = 'admin@pocket.com'
    password = 'defaultAdminPassword'

    user = User.find_by(email: email)

    unless user.present?
      puts "Going to create admin user with email=#{email}"
      user = User.create(email: email, password: password)
      puts "Created user=#{user.attributes}"
    end
  end
end
