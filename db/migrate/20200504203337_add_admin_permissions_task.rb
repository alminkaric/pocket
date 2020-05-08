# frozen_string_literal: true

class AddAdminPermissionsTask < ActiveRecord::Migration[6.0]
  def up
    Rake::Task['permissions:add_admin_permissions_for_user_service'].invoke
  end
end
