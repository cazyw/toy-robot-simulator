require 'rake/testtask'

Rake::TestTask.new do |t|
    t.libs << "tests"
    t.test_files = FileList['tests/test_table.rb', 'tests/test_robot.rb']
    t.verbose = false
end