class AddExperienceToUser < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :experience, :string
  end
end
