# == Schema Information
#
# Table name: task_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  batch_size :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TaskType < ActiveRecord::Base
  attr_accessible :name, :batch_size
  has_many :tasks
end
