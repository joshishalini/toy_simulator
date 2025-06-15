require_relative './robot'

# Simulator class is responsible for parsing and executing robot commands
class Simulator
  def initialize
    # Create a new Robot instance to control
    @placed = false
    @robot = Robot.new
  end

  # Main method to run the simulation with input command string
  def run(input)
    # Process each line/command one by one
    input.each_line do |line|
      # Parse the command and any associated arguments
      command, args = parse_command(line.strip)
      # Execute the parsed command
      execute_command(command, args)
    end
  end

  private

  # Parses a single line of input and returns the command and arguments
  def parse_command(line)
    # If the line starts with 'PLACE', extract the coordinates and direction
    if line.start_with?('PLACE')
      parts = line.split(' ')
      args = parts.last.split(',') if parts.size > 1
      return ['PLACE', args]
    else
      # For other commands (e.g. MOVE, LEFT), return command in uppercase with no args
      return [line.strip.upcase, nil]
    end
  end

  # Executes a command by calling the appropriate method on the robot
  def execute_command(command, args)
    case command
    when 'PLACE'
      return unless args&.size == 3
      x, y, dir = args
      @robot.place(x.to_i, y.to_i, dir.upcase)
      @placed = true
    when 'MOVE'
      @robot.move if @placed
    when 'LEFT'
      @robot.left if @placed
    when 'RIGHT'
      @robot.right if @placed
    when 'REPORT'
      return unless @placed
      response = @robot.report 
      puts "#{response[:x]},#{response[:y]},#{response[:direction]}"
    end
  end
end

# Example use
input = "PLACE 0,0,NORTH
MOVE
REPORT
PLACE 0,0,NORTH
LEFT
REPORT
PLACE 1,2,EAST
MOVE
MOVE
LEFT
MOVE
REPORT"

simulator = Simulator.new
simulator.run(input)

