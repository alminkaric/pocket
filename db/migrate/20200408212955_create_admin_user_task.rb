# frozen_string_literal: true

class CreateAdminUserTask < ActiveRecord::Migration[6.0]
  def up
    Rake::Task['users:create_admin_user'].invoke
  end
end
