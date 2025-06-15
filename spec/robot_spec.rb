# frozen_string_literal: true

require_relative '../lib/robot'

RSpec.describe Robot do
  let(:robot) { Robot.new }

  describe '#place' do
    it 'places the robot at a valid position' do
      robot.place(1, 1, 'NORTH')
      expect(robot.report).to eq({ x: 1, y: 1, direction: 'NORTH' })
    end

    it 'ignores invalid positions' do
      robot.place(5, 5, 'NORTH')
      expect(robot.report).to eq({ x: 0, y: 0, direction: nil })
    end

    it 'ignores invalid direction' do
      robot.place(2, 2, 'UP')
      expect(robot.report).to eq({ x: 0, y: 0, direction: nil })
    end
  end

  describe '#move' do
    it 'moves north if facing north and space ahead' do
      robot.place(0, 0, 'NORTH')
      robot.move
      expect(robot.report).to eq({ x: 0, y: 1, direction: 'NORTH' })
    end

    it 'prevents falling off the table' do
      robot.place(0, 4, 'NORTH')
      robot.move
      expect(robot.report).to eq({ x: 0, y: 4, direction: 'NORTH' })
    end
  end

  describe '#left and #right' do
    it 'turns left from NORTH to WEST' do
      robot.place(0, 0, 'NORTH')
      robot.left
      expect(robot.report[:direction]).to eq('WEST')
    end

    it 'turns right from NORTH to EAST' do
      robot.place(0, 0, 'NORTH')
      robot.right
      expect(robot.report[:direction]).to eq('EAST')
    end
  end

  describe '#report' do
    it 'return the correct output' do
      robot.place(2, 3, 'SOUTH')
      expect(robot.report).to eq({ x: 2, y: 3, direction: 'SOUTH' })
    end
  end

  describe 'command sequence' do
    it 'executes a valid sequence correctly' do
      robot.place(1, 2, 'EAST')
      robot.move
      robot.move
      robot.left
      robot.move
      expect(robot.report).to eq({ x: 3, y: 3, direction: 'NORTH' })
    end
  end
end
