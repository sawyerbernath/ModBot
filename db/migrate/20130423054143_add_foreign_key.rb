class AddForeignKey < ActiveRecord::Migration
  def up
    add_column :tasks, :elf_id, :integer
  end

  def down
    remove_column :tasks, :elf_id
  end
end
