# == Schema Information
#
# Table name: tasks
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  quantity     :integer
#  notes        :text
#  status       :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  elf_id       :integer
#  task_type_id :integer
#

class Task < ActiveRecord::Base
  attr_protected :id, :created_at, :updated_at
  belongs_to :elf
  belongs_to :task_type
end
