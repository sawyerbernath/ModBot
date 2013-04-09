class CreateElves < ActiveRecord::Migration
  def up
    create_table 'elves' do |e|
      e.string 'name'
    end
  end

  def down
    drop_table 'elves' # deletes the whole table and all its data!
  end
end
