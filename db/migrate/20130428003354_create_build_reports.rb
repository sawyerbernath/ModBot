#TaskType columns are in an ongoing set of
#other migrations.

class CreateBuildReports < ActiveRecord::Migration
  def change
    create_table :build_reports do |t|
      t.string 'title'
      t.datetime 'start'
      t.datetime 'end'

      t.timestamps
    end
  end
end
