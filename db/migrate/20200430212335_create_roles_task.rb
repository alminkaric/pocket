# typed: true
# frozen_string_literal: true

class CreateRolesTask < ActiveRecord::Migration[6.0]
  def up
    Rake::Task['roles:create_default_roles'].invoke
  end
end
