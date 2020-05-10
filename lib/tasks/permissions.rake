# frozen_string_literal: true

namespace :permissions do
  desc 'Creates admin permission for user service'
  task add_admin_permissions_for_user_service: :environment do
    methods_to_add_permission = UserService.instance_methods(false)

    puts "Going to add admin permissions for #{methods_to_add_permission}"
    methods_to_add_permission.each do |method_name|
      permission = Permission.find_or_create_by(
        class_name: UserService.name,
        method_name: method_name,
        holder: Role.admin
      )

      permission.save
      puts "Created #{permission.attributes}"
    end
  end

  desc 'Creates admin permission for role service'
  task add_admin_permissions_for_role_service: :environment do
    methods_to_add_permission = RoleService.instance_methods(false)

    puts "Going to add admin permissions for #{methods_to_add_permission}"
    methods_to_add_permission.each do |method_name|
      permission = Permission.find_or_create_by(
        class_name: RoleService.name,
        method_name: method_name,
        holder: Role.admin
      )

      permission.save
      puts "Created #{permission.attributes}"
    end
  end

  desc 'Creates admin permission for permission service'
  task add_admin_permissions_for_permission_service: :environment do
    methods_to_add_permission = PermissionService.instance_methods(false)

    puts "Going to add admin permissions for #{methods_to_add_permission}"
    methods_to_add_permission.each do |method_name|
      permission = Permission.find_or_create_by(
        class_name: PermissionService.name,
        method_name: method_name,
        holder: Role.admin
      )

      permission.save
      puts "Created #{permission.attributes}"
    end
  end
end
