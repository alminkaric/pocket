# frozen_string_literal: true

class AddAdminUserRoleTask < ActiveRecord::Migration[6.0]
  def up
    Rake::Task['role_assignments:add_admin_user_role'].invoke
  end
end
