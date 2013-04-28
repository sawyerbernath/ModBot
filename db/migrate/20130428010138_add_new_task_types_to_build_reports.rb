#When new TaskTypes are added, MAKE A NEW MIGRATION!!!
#Reuse this code, but copy/paste. 

class AddNewTaskTypesToBuildReports < ActiveRecord::Migration
  def change
    TaskType.all.each do |a|
      if column_exists? :build_reports, "#{a.name}_passed"
      else
        change_table :build_reports do |t|
          t.integer "#{a.name}_passed"
          t.integer "#{a.name}_failed"
          t.float "#{a.name}_hours"
        end
      end
    end
  end
end
