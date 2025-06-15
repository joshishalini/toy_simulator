class Robot
  # Define allowed X and Y ranges and directions
  X_RANGE = (0..4).to_a.freeze
  Y_RANGE = (0..4).to_a.freeze
  DIRECTIONS = ['NORTH', 'SOUTH', 'EAST', 'WEST'].freeze

  # Initialize robot's position and direction
  def initialize
    @x = 0
    @y = 0
    @direction = nil
  end

  # Place the robot at a valid location and direction
  def place(x, y, direction)
    return unless valid_position?(x, y, direction)

    @x = x
    @y = y
    @direction = direction
  end

  # Move the robot one unit forward in the current direction, if within bounds
  def move
    return unless placed?

    case @direction
    when 'NORTH'
      @y += 1 if Y_RANGE.include?(@y + 1)
    when 'SOUTH'
      @y -= 1 if Y_RANGE.include?(@y - 1)
    when 'EAST'
      @x += 1 if X_RANGE.include?(@x + 1)
    when 'WEST'
      @x -= 1 if X_RANGE.include?(@x - 1)
    end
  end

  # Rotate the robot 90 degrees to the left
  def left
    return unless placed?

    case @direction
    when 'NORTH'
      @direction = 'WEST'
    when 'SOUTH'
      @direction = 'EAST'
    when 'EAST'
      @direction = 'NORTH'
    when 'WEST'
      @direction = 'SOUTH'
    end
  end

  # Rotate the robot 90 degrees to the right
  def right
		return unless placed?

    case @direction
    when 'NORTH'
      @direction = 'EAST'
    when 'SOUTH'
      @direction = 'WEST'
    when 'EAST'
      @direction = 'SOUTH'
    when 'WEST'
      @direction = 'NORTH'
    end
  end

  # Output current position and direction
  def report
    {x: @x, y: @y, direction: @direction}
  end

  private

  # direction set or not
	def placed?
    !@direction.nil?
  end

  # Validate placement input
  def valid_position?(x, y, direction)
  	return false unless x.is_a?(Integer) && y.is_a?(Integer) && direction.is_a?(String)

    X_RANGE.include?(x) && Y_RANGE.include?(y) && DIRECTIONS.include?(direction)
  end
end

# # Sample usage
# r = Robot.new
# r.place(0, 0, 'NORTH')  # Place at origin facing NORTH
# r.move                 # Move to (0,1)
# puts r.report          # Output: X: 0, Y: 1, direction: NORTH

# r.place(0, 0, 'NORTH')  # Reset to (0,0) facing NORTH
# r.left                 # Turn left -> now facing WEST
# puts r.report          # Output: X: 0, Y: 0, direction: WEST

# r.place(1, 2, 'EAST')  # Place at (1,2) facing EAST
# r.move                 # (2,2)
# r.move                 # (3,2)
# r.left                 # now facing NORTH
# r.move                 # (3,3)
# puts r.report          # Output: X: 3, Y: 3, direction: NORTH
