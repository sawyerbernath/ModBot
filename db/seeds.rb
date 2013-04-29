some_task_types = [
                   {:name => ''},
                   {:name => 'Assemble Drive Halves', :batch_size => 32},
                   {:name => 'Mate Cubes', :batch_size => 64},
                   {:name => 'Test Passives', :batch_size => 32, :test => true, :final => true},
                   {:name => 'Circuit Boarding', :batch_size => 64, :test => true}
                  ]
some_task_types.each {|t| TaskType.create! t}

some_tasks = [
              
             ]
#some_tasks.each {|t| Task.create!(t)}

some_elves = [
              {:name => ''},                 #assigned when task is posted
              {:name => 'Sawyer Bernath'},
              {:name => 'Kristin Yen'},
              {:name => 'Chris Borke'},
              {:name => 'Keegan Ridgley'},
              {:name => 'Karl Stokely'},
              {:name => 'Ying Her'},
              {:name => 'Logan Priess'},
              {:name => 'Joe Ferry'},
              {:name => 'Jenny Chambers'},
              {:name => 'Michael Kramer'}
             ]
some_elves.each do |e| 
  elf = Elf.create!(e)
  elf.tasks.create
end

Task.all.each do |t| 
  t.task_type = (TaskType.where 'name == ""').first
  t.save
end
