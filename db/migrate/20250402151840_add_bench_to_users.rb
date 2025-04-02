class AddBenchToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :bench, :boolean
  end
end
