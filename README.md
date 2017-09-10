# Toy Robot Simulator
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

`bundler` (to install ruby gems required)

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
2. If you are using the test files, install the required ruby gems (rake and test-unit)

```
$ bundle install
```

## Operating Instructions

Open a terminal to run the toy robot simulator (direction of '\\' will vary according to the environment - windows environment below)

```
$ ruby .\lib\toy_robot.rb
```

See the Overview section below for further instructions


## Testing Instructions

To run the test suite, run the command (in \toyRobotSimulator)

```
$ rake test
```

## Overview

The application simulates the movements of a robot on a 5x5 grid. Users first place the robot on the table facing a particular direction, and then move and turn the robot.  Users can then end the application and obtain the robot's location.

### Commands  

The following commands (case insensitive) are valid:

* `PLACE x, y, DIRECTION` - places the robot on the table. the `x` and `y` coordinates must be between 0 and 4, with (0, 0) being the south-west corner of the table. Direction values are `NORTH`, `SOUTH`, `EAST`, `WEST`. 
* `MOVE` - moves the robot one square in the direction it's facing
* `LEFT` - turns the robot 90' to the left on the spot
* `RIGHT` - turns the robot 90' to the right on the spot
* `REPORT` - ends the application and displays the robot's location

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
The program will terminate with the command `REPORT` and output the location of the robot to `$stdout`.

```
X X X X X
X X X O X
X X X X X
X X X X X
X X X X X
Output: (2,4) facing EAST
```

### Restrictions
1. The robot cannot be placed or moved off the table. Any commands resulting in this outcome will be ignored
2. The robot must be placed on the table before any of the other commands are actioned

## Discussion
For this application I modeled the game in a ToyRobot class. This was so that instances of the robot game could be created and the state of the robot tracked. The input mechanics were placed in an outside separate method.

Currently the entire application runs from one file with the input commands and robot modelling together. This should be separated into at least two files with the ToyRobot class in a separate file for re-usability. 

The test cases were written using test-unit (Test::Unit) as this was the first framework I'd used. The test cases test the class methods involved in placing and moving pieces around the table. At the moment it does not test user input from $stdin (the play_game method) which is something I need to investigate further. The testing for this was done manually by running the simulation and testing different inputs. 

Although it was not required to output a pictorial representation of the robot and table, I had implemented the grid as one of the first steps of building the application. This was to help me to visualise and understand where the robot was and the direction it was moving. Although it's been removed as an output after every command, I have left it in the final output when the robot's location is reported.


## Contributing
Carol Wong
