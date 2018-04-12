#!/usr/bin/env ruby

local_lib = File.expand_path('../', __FILE__)
$LOAD_PATH.unshift(local_lib) unless $LOAD_PATH.include?(local_lib)

require "robot"
require "grid"

# == Example input
#
# PLACE X,Y,F
# MOVE
# LEFT
# RIGHT
# REPORT

COMMANDS = {
  "PLACE" => :place,
  "MOVE" => :move,
  "LEFT" => :left,
  "RIGHT" => :right,
  "REPORT" => :report
}

SEPARATORS_REGEX = %r{[ |,\s*]}

table = Grid.new
robot = Robot.new(table)
filename = ARGV.first

if !filename
  loop do
    input, *args = gets.chomp.split(SEPARATORS_REGEX)
    command = COMMANDS[input]
    robot.method(command).call(*args) if command
    break if input == "EXIT"
  end
else
  File.readlines(filename).each do |line|
    input, *args = line.strip.split(SEPARATORS_REGEX)
    command = COMMANDS[input]
    robot.method(command).call(*args) if command
  end
end
