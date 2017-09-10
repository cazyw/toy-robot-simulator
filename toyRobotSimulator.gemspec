# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "Toy Robot Simulator"
  spec.version       = '1.0'
  spec.authors       = ["Carol Wong"]
  spec.email         = ["cyswong@gmail.com"]
  spec.summary       = %q{Simulator to place and move a robot on a 5x5 table}
  spec.description   = %q{Users can place a robot on a 5x5 table and move the robot around the table before checking the location of the robot. Users can run this game either via commands in the terminal or by inputting a file with a list of commands}
  spec.homepage      = "https://github.com/cazyw/toyRobotSimulator/"
  spec.license       = "MIT"

  spec.files         = ['lib/toy_robot.rb']
  spec.executables   = ['']
  spec.test_files    = ['tests/test_toy_robot.rb']
  spec.require_paths = ["lib"]
end