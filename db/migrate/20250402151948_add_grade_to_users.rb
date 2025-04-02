class AddGradeToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :grade, :integer
  end
end
