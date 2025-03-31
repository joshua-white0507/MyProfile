class AddPracticeToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :practice, :string
  end
end
