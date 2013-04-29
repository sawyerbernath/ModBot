#When new TaskTypes are added, MAKE A NEW MIGRATION!!!
#Reuse this code, but copy/paste. 

PATH =  "#{Rails.root}/db/migration_files/20130428010138.txt"

class AddNewTaskTypesToBuildReports < ActiveRecord::Migration
  def up
    file = File.new PATH, 'w'
    TaskType.where("name != ''").all.each do |a|
      b = a.name.gsub(/ /, '').underscore
      if column_exists? :build_reports, "#{b}_passed"
      else
        change_table :build_reports do |t|
          t.integer "#{b}_passed", :default => 0
          t.integer "#{b}_failed", :default => 0
          t.float "#{b}_hours", :default => 0
        end
        file.puts b
      end
    end
    file.close
  end

  def down
    file = File.open PATH, 'r'
    file.each do |b|
      b.chomp!
      change_table :build_reports do |t|
        t.remove "#{b}_passed", "#{b}_failed", "#{b}_hours"
      end
    end
    file.close
    File.delete PATH
  end
end
