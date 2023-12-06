require_relative './lib.rb'

input = get_input(6)
example = "Time:      7  15   30
Distance:  9  40  200"

def part1(input)
  times, distances = input.split("\n").map { |line| line.split[1..-1].map(&:to_i) }
  beats = times.map.with_index do |time, i|
    max_distance = distances[i]
    subtotal = 0
    for i in 1..time
      time_left = time - i
      reached = i * time_left
      if reached > max_distance
        subtotal += 1
      end
    end
    subtotal
  end
  return beats.inject(:*)
end

puts part1(input)