# == Schema Information
#
# Table name: tasks
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  quantity   :integer
#  notes      :text
#  status     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  elf_id     :integer
#

class Task < ActiveRecord::Base
  belongs_to :elf
end
