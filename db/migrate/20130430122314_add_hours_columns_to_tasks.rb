class AddHoursColumnsToTasks < ActiveRecord::Migration
  def up
    change_table :tasks do |t|
      t.float :hours_posted
      t.float :hours_in_progress
    end
  end

  def down
    remove_column :tasks, :hours_posted
    remove_column :tasks, :hours_in_progress
  end
end
