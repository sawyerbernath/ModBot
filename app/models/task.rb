# == Schema Information
#
# Table name: tasks
#
#  id                :integer          not null, primary key
#  quantity          :integer
#  notes             :text
#  status            :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  elf_id            :integer
#  task_type_id      :integer
#  passed            :integer
#  failed            :integer
#  hours_posted      :float
#  hours_in_progress :float
#

class Task < ActiveRecord::Base
  attr_protected :id, :created_at, :updated_at
  belongs_to :elf
  belongs_to :task_type
end
