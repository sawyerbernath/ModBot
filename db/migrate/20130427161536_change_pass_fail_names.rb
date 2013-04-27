class ChangePassFailNames < ActiveRecord::Migration
  def change
    change_table :tasks do |t|
      t.rename :pass, :passed
      t.rename :fail, :failed
    end
  end
end
