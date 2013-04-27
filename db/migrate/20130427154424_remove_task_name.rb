class RemoveTaskName < ActiveRecord::Migration
  def up
    remove_column :tasks, :name
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
