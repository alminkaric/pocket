# typed: true
# frozen_string_literal: true

class CreatePermissions < ActiveRecord::Migration[6.0]
  def change
    create_table :permissions do |t|
      t.string :class_name, null: false
      t.string :method_name, null: false
      t.references :holder, polymorphic: true, null: false

      t.timestamps
    end
  end
end
