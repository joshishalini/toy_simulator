require_relative '../lib/simulator'

RSpec.describe Simulator do
  let(:simulator) { Simulator.new }

  describe '#run' do
    it 'places and moves the robot correctly' do
      expect {
        simulator.run("PLACE 1,2,EAST\nMOVE\nMOVE\nLEFT\nMOVE\nREPORT")
      }.to output("3,3,NORTH\n").to_stdout
    end

    it 'rotates left from NORTH to WEST' do
      expect {
        simulator.run("PLACE 0,0,NORTH\nLEFT\nREPORT")
      }.to output("0,0,WEST\n").to_stdout
    end

    it 'rotates right from NORTH to EAST' do
      expect {
        simulator.run("PLACE 0,0,NORTH\nRIGHT\nREPORT")
      }.to output("0,0,EAST\n").to_stdout
    end

    it 'does not move in wrong direction' do
      expect {
        simulator.run("PLACE 0,0,SOUTH\nMOVE\nREPORT")
      }.to output("0,0,SOUTH\n").to_stdout
    end

    it 'overrides previous position with new PLACE' do
      expect {
        simulator.run("PLACE 0,0,NORTH\nMOVE\nPLACE 2,2,WEST\nREPORT")
      }.to output("2,2,WEST\n").to_stdout
    end

    it 'ignores invalid commands' do
      expect {
        simulator.run("PLACE 0,0,NORTH\nJUMP\nFLY\nREPORT")
      }.to output("0,0,NORTH\n").to_stdout
    end

    it 'ignores commands before PLACE' do
      expect {
        simulator.run("MOVE\nLEFT\nRIGHT\nREPORT\nPLACE 1,1,NORTH\nREPORT")
      }.to output("1,1,NORTH\n").to_stdout
    end
  end
end
