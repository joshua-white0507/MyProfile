class AddInterestToUser < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :interest, :string
  end
end
