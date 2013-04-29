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
#  assemble_drive_halves_passed :integer          default(0)
#  assemble_drive_halves_failed :integer          default(0)
#  assemble_drive_halves_hours  :float            default(0.0)
#  mate_cubes_passed            :integer          default(0)
#  mate_cubes_failed            :integer          default(0)
#  mate_cubes_hours             :float            default(0.0)
#  test_passives_passed         :integer          default(0)
#  test_passives_failed         :integer          default(0)
#  test_passives_hours          :float            default(0.0)
#  circuit_boarding_passed      :integer          default(0)
#  circuit_boarding_failed      :integer          default(0)
#  circuit_boarding_hours       :float            default(0.0)
#

class BuildReport < ActiveRecord::Base
  attr_protected :id
end
