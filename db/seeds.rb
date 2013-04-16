# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

some_tasks = [
              {:name => 'Inverse bottoms', :quantity => 32, :notes => '',
                :status => 'Posted'},
              {:name => 'Flash cubes', :status => 'Posted'},
              {:name => 'Circuit boarding', :status => 'In Progress',
                :elf_id => 2}
]

Task.send(:attr_accessible, :name, :quantity, :notes, :status, :elf_id)
some_tasks.each {|t| Task.create!(t)}

some_elves = [
              {:name => 'Sawyer Bernath'},
              {:name => 'Kristin Yen'},
              {:name => 'Chris Borke'},
              {:name => 'Keegan Ridgley'},
              {:name => 'Karl Stokely'},
              {:name => 'Ying Her'},
              {:name => 'Logan Priess'}
]
some_elves.each {|e| Elf.create!(e)}
