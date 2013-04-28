# == Schema Information
#
# Table name: build_reports
#
#  id                           :integer          not null, primary key
#  title                        :string(255)
#  start                        :datetime
#  end                          :datetime
#  _passed                      :integer
#  _failed                      :integer
#  _hours                       :float
#  Assemble Drive Halves_passed :integer
#  Assemble Drive Halves_failed :integer
#  Assemble Drive Halves_hours  :float
#  Mate Cubes_passed            :integer
#  Mate Cubes_failed            :integer
#  Mate Cubes_hours             :float
#  Test Passives_passed         :integer
#  Test Passives_failed         :integer
#  Test Passives_hours          :float
#  Circuit Boarding_passed      :integer
#  Circuit Boarding_failed      :integer
#  Circuit Boarding_hours       :float
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#

class BuildReport < ActiveRecord::Base
  attr_protected :id
end
