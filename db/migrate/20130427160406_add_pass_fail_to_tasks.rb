class AddPassFailToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :pass, :integer
    add_column :tasks, :fail, :integer
  end
end
