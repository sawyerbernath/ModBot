# == Schema Information
#
# Table name: build_reports
#
#  id                           :integer          not null, primary key
#  title                        :string(255)
#  start                        :datetime
#  end                          :datetime
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  assemble_drive_halves_passed :integer
#  assemble_drive_halves_failed :integer
#  assemble_drive_halves_hours  :float
#  mate_cubes_passed            :integer
#  mate_cubes_failed            :integer
#  mate_cubes_hours             :float
#  test_passives_passed         :integer
#  test_passives_failed         :integer
#  test_passives_hours          :float
#  circuit_boarding_passed      :integer
#  circuit_boarding_failed      :integer
#  circuit_boarding_hours       :float
#

class BuildReport < ActiveRecord::Base
  attr_protected :id
end
