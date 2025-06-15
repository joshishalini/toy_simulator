# Toy Robot Simulator

A Ruby command-line application that simulates a toy robot moving on a 5x5 tabletop grid.

---

## Problem Statement

- The tabletop is a 5x5 grid with the origin (0,0) at the **south-west corner**.
- The robot can face one of four directions: `NORTH`, `SOUTH`, `EAST`, or `WEST`.
- The robot must be placed using a `PLACE` command before any other command is accepted.
- The simulator can read commands
- A `REPORT` command prints the robot’s position and direction (e.g., `3,3,NORTH`).

---

## Supported Commands

| Command       | Description |
|---------------|-------------|
| `PLACE X,Y,F` | Places the robot at position (X,Y) facing direction `F` |
| `MOVE`        | Moves the robot forward one unit in the direction it is currently facing |
| `LEFT`        | Rotates the robot 90° to the left |
| `RIGHT`       | Rotates the robot 90° to the right |
| `REPORT`      | Prints the current position and direction of the robot |

---

## Example Input

```text
PLACE 1,2,EAST
MOVE
MOVE
LEFT
MOVE
REPORT
```

## How to Run
```ruby
input = "
  PLACE 1,2,EAST
  MOVE
  MOVE
  LEFT
  MOVE
  REPORT
"

sim = Simulator.new
sim.run(input)
```

## Running Test
```text
bundle install
bundle exec rspec
```

## My Approach
- Began by implementing the core movement logic in robot.rb, ensuring the robot could be placed, moved, and rotated correctly.
- Then built simulator.rb to handle parsing and executing user commands, mapping them to the corresponding robot actions.
- Added basic validation to ignore commands issued before the robot is placed, and gracefully skip invalid or unrecognized commands.
- Wrote RSpec tests to verify expected behaviors and edge cases.
- Included inline comments for better clarity and maintainability.

## If I Had More Time
- Added more robust validation and error handling unsupported commands.
- Allowed dynamic table sizing instead of a fixed 5x5 grid (e.g., configurable via input).
- Explored multiplayer or multiple robot support, enabling independent control of multiple robots on the same grid.

