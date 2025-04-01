class RemoveInterestFromUsers < ActiveRecord::Migration[7.2]
  def change
    remove_column :users, :Interest, :string
  end
end
