# Toy Robot Simulator
Version 2.0

A toy robot can be placed on a 5 x 5 table and moved around on the table. Users can either manually enter commands or load commands via a file. 

## Environment
Built and tested on Windows 10 Home and Ruby 2.3.3p222. The simulator has not been tested in other environments.

## System Dependencies & Configuration
`ruby => 2.3.3`

To check your version run: 

```
$ ruby -v
```

To learn how to install ruby visit [https://www.ruby-lang.org/en/installation/]

`bundler` (to install any ruby gems required)

To check your version run: 

```
$ bundler -v
```

If it's not installed, run 

```
$ gem install bundler
```

## Application Installation Instructions
1. Clone or download this repository
2. If you are using the test files, install any required ruby gems (e.g. rake and test-unit)

```
$ bundle install
```

## Operating Instructions

Open a terminal to run the toy robot simulator (direction of '\\' may vary according to the environment - commands below are for a windows environment )

```
$ ruby .\lib\toy_robot_sim.rb [for gitbash remember to prefix with $ winpty ruby ....]
```

See the Overview section below for further instructions


## Testing Instructions

To run the test suite, run the command (in \toyRobotSimulator)

```
$ rake test
```

Example test files are provided that contain a list of commands

## Overview

The application simulates the movements of a robot on a 5x5 grid. Users first place the robot on the table facing a particular direction, and then move and turn the robot.  Users can obtain a report of the robot's location at any time.

### Commands  

The following commands (case insensitive) are valid:

* `PLACE x, y, DIRECTION` - places the robot on the table. the `x` and `y` coordinates must be between 0 and 4, with (0, 0) being the south-west corner of the table. Direction values are `NORTH`, `SOUTH`, `EAST`, `WEST`. 
* `MOVE` - moves the robot one square in the direction it's facing
* `LEFT` - turns the robot 90' to the left on the spot
* `RIGHT` - turns the robot 90' to the right on the spot
* `REPORT` - displays the robot's location
* `EXIT` - exits the simulator

Invalid commands will output a message to `$stdout`.

After beginning the application you will need to choose to either control the robot via existing commands in a `file` or to manually enter the commands via `stdin`.

```
Choose 'file' or 'stdin': file
```

### File input
Enter the filename. If the file does not exist, a prompt will continue to appear until a valid file is entered. 

```
Enter a file: .\tests\robot_commands_4.txt
``` 

Only one file can be run at a time.
The file should contain one command per line

```
In .\tests\robot_commands_4.txt:

PLACE 1, 3, NORTH
MOVE
RIGHT
MOVE
REPORT
```

### Standard input
Enter one command at a time at the prompt `>`

```
> PLACE 1, 3, NORTH
> MOVE
> RIGHT
> MOVE
> REPORT
```
### Output
Entering `REPORT` will output the location of the robot to `$stdout`. The position of the robot can be checked at any time.

```
Output: [2, 4] facing EAST
X X X X X
X X X O X
X X X X X
X X X X X
X X X X X
```

### Restrictions
1. The robot cannot be placed or moved off the table. Any commands resulting in this outcome will be ignored
2. The robot must be placed on the table before any of the other commands are actioned

## Discussion
The game consists of a number of files. 
* `toy_robot_sim.rb` contains the overall method interacting with the user
* the `Table` and `Robot` classes hold the states of the respective objects
* the `Game` class sets up the table and robot and runs the game based on the comands given   
* the `Setting` module contains constants and general print/error methods 

Initially all contained in one file with long methods, the program has been broken down into smaller components for easier readability, maintainence and re-use of code. It is also possible to change the size of the game as the table size is now set with a constant variable that can be modified (in `Setting`).

The test cases were written using test-unit (Test::Unit) as this was the first framework I'd used. The test cases test the class methods involved in placing and moving pieces around the table. At the moment it does not test user input from $stdin (the play_game method).

Although it was not required to output a pictorial representation of the robot and table, I had implemented the grid as one of the first steps of building the application. This was to help me to visualise and understand where the robot was and the direction it was moving. Although it's been removed as an output after every command, I have left it in the final output when the robot's location is reported.

For a longer game (and because it assisted with testing), the `REPORT` command no longer ends the game but simply reports the location of the robot. Users can continue to play the simulator. The simulator now ends on the `EXIT` command.

## Contributing
Carol Wong
