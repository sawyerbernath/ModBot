class AddElvesToTasks < ActiveRecord::Migration
  def up
    add_column :tasks, :elf_id, :integer
    remove_column :tasks, :elf
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
