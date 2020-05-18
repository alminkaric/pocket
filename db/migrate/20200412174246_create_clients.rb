# typed: true
# frozen_string_literal: true

class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :description
      t.integer :status, default: 0
      t.date :start_of_trial
      t.integer :trial_days

      t.timestamps
    end
  end
end
