# frozen_string_literal: true

class CreatePermissions < ActiveRecord::Migration[6.0]
  def change
    create_table :permissions do |t|
      t.string :class_name
      t.string :method_name
      t.references :holder, polymorphic: true, null: false

      t.timestamps
    end
  end
end
