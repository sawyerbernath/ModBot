class CreateElves < ActiveRecord::Migration
  def change
    create_table :elves do |t|
      t.string :name
      t.integer :task_id
      #Ideas: Level, what tasks they're trained in...

      t.timestamps
    end
  end
end
