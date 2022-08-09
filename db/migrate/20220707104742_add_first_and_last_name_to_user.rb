# frozen_string_literal: true

class AddFirstAndLastNameToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :first_name, :text
    add_column :users, :last_name, :text
  end
end
