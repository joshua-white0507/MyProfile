class ChangePreviousClientsToArray < ActiveRecord::Migration[7.2]
  def change
    remove_column :users, :previous_clients, :text

    # Add the column back as an array
    add_column :users, :previous_clients, :text, array: true, default: []
  end
end
