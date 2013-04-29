class AddTestAndFinalToTaskType < ActiveRecord::Migration
  def change
    add_column :task_types, :test, :boolean, :default => false
    add_column :task_types, :final, :boolean, :default => false
  end
end
