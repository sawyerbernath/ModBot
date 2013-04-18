# == Schema Information
#
# Table name: elves
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  task_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Elf < ActiveRecord::Base
  attr_accessible :name, :task_id
  has_many :tasks
end
