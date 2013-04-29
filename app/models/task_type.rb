# == Schema Information
#
# Table name: task_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  batch_size :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  test       :boolean          default(FALSE)
#  final      :boolean          default(FALSE)
#

class TaskType < ActiveRecord::Base
  attr_protected :id, :created_at, :updated_at
  has_many :tasks
end
