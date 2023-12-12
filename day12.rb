require_relative './lib.rb'

input = get_input(12)

def parse_input(input)
  input
    .split("\n")
    .map do |line|
      arrangement, second = line.split(' ')
      conditions = second.split(',').map(&:to_i)
      [arrangement, conditions]
    end
end

def generate_strings_with_limit(input, max_broken_count)
  queue = [[input, 0, 0]]
  results = []

  until queue.empty?
    current_input, current_broken_count, index = queue.shift

    if index == current_input.length
      results << current_input
      next
    end

    char = current_input[index]

    if char == '?'
      if current_broken_count < max_broken_count
        queue << [
          current_input.dup.tap { |s| s[index] = '#' },
          current_broken_count + 1,
          index + 1
        ]
      end

      queue << [
        current_input.dup.tap { |s| s[index] = '.' },
        current_broken_count,
        index + 1
      ]
    else
      queue << [current_input, current_broken_count, index + 1]
    end
  end

  results
end

def calculate_possible_placements(arrangement, conditions)
  max_broken_count = conditions.sum - arrangement.count('#')
  possible_placements =
    generate_strings_with_limit(arrangement, max_broken_count)
  possible_placements.select do |placement|
    placement.scan(/#+/).map(&:length) == conditions
  end
end

def part1(input)
  input.sum do |arrangement, conditions|
    calculate_possible_placements(arrangement, conditions).length
  end
end

def part2(input)
end

example = <<-INPUT
???.### 1,1,3
.??..??...?##. 1,1,3
?#?#?#?#?#?#?#? 1,3,1,6
????.#...#... 4,1,1
????.######..#####. 1,6,5
?###???????? 3,2,1
INPUT

parsed = parse_input(input)
puts "Part 1: #{part1(parsed)}"
