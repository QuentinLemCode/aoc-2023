require_relative './lib.rb'

input = get_input(6)
example =
  'Time:      7  15   30
Distance:  9  40  200'

def part1(input)
  times, distances =
    input.split("\n").map { |line| line.split[1..-1].map(&:to_i) }
  beats =
    times.map.with_index do |time, i|
      max_distance = distances[i]
      subtotal = 0
      for i in 1..time
        time_left = time - i
        reached = i * time_left
        subtotal += 1 if reached > max_distance
      end
      subtotal
    end
  return beats.inject(:*)
end

def race(input, time)
  (time - input) * input
end

def part2(input)
  time, max_distance =
    input.split("\n").map { |line| line.split[1..-1].join('').to_i }

  discr = time**2 - 4 * max_distance

  if discr > 0
    sqrt_discriminant = Math.sqrt(discr)
    x1 = (time + sqrt_discriminant) / 2.0
    x2 = (time - sqrt_discriminant) / 2.0
    result = [x1, x2].sort.map(&:floor)
    return result[1] - result[0]
  end
end

puts part1(input)
puts part2(input)
