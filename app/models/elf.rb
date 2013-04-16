class Elf < ActiveRecord::Base
  attr_accessible :name, :task_id
  has_many :tasks
end
