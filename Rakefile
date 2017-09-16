require 'rake/testtask'

Rake::TestTask.new do |t|
    t.libs << "tests"
    t.test_files = FileList['tests/test_table.rb', 'tests/test_robot.rb', 'tests/test_game.rb']
    t.verbose = false
end