class CreateTasks < ActiveRecord::Migration
  def up
    create_table 'tasks' do |t|
      t.string 'name'
      t.integer 'quantity'
      t.text 'notes'
      t.string 'status'
      t.string 'elf'

      t.timestamps
    end
  end

  def down
    drop_table 'tasks'
  end
end
