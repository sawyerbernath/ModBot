class CreateTaskTypes < ActiveRecord::Migration
  def change
    create_table :task_types do |t|
      t.string :name
      t.integer :batch_size

      t.timestamps
    end

    add_column :tasks, :task_type_id, :integer
  end
end
