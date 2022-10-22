# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[7.0]
  def change # rubocop:disable Metrics/MethodLength
    create_table :users do |t|
      t.string :email, null: false, default: '', index: { unique: true }
      t.string :encrypted_password, null: false, default: ''

      t.string :reset_password_token, index: { unique: true }
      t.datetime :reset_password_sent_at

      t.datetime :remember_created_at

      t.string :confirmation_token, index: { unique: true }
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string :unconfirmed_email

      t.string :name, null: false
      t.string :username, null: false, index: { unique: true }
      t.string :description, null: false, default: ''

      t.timestamps null: false
    end
  end
end
