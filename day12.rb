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

def memoize(result, memo, pos, conditions)
  memo[pos] ||= {}
  memo[pos][conditions.length] = result
end

def count_arrangements(arrangement, pos, conditions, min_length, memo)
  if memo[pos]&.[](conditions.length).is_a?(Integer)
    return memo[pos][conditions.length]
  end
  if conditions.empty?
    return 0 if (arrangement[pos..-1]&.index('#') || -1) >= 0
    return 1
  end
  if pos + min_length > arrangement.length
    return memoize(0, memo, pos, conditions)
  end
  if arrangement[pos] == '.'
    nextpos = arrangement[pos + 1..-1].chars.find_index { |c| c != '.' }
    result =
      count_arrangements(
        arrangement,
        pos + (nextpos || 0) + 1,
        conditions,
        min_length,
        memo
      )
    return(memoize(result, memo, pos, conditions))
  end
  if (pos >= arrangement.length)
    return memoize(1, memo, pos, conditions) if conditions.length === 0
    return memoize(0, memo, pos, conditions)
  end

  if arrangement[pos] == '#'
    if arrangement.length - pos < conditions[0]
      return memoize(0, memo, pos, conditions)
    end
    conditions[0].times do |i|
      return memoize(0, memo, pos, conditions) if arrangement[pos + i] == '.'
    end
    if arrangement[pos + conditions[0]] == '#'
      return memoize(0, memo, pos, conditions)
    end
    result =
      count_arrangements(
        arrangement,
        pos + conditions[0] + 1,
        conditions[1..-1],
        min_length - conditions[0] - 1,
        memo
      )
    return(memoize(result, memo, pos, conditions))
  elsif arrangement[pos] == '?'
    result =
      count_arrangements(arrangement, pos + 1, conditions, min_length, memo)
    if arrangement.length - pos < conditions[0]
      return memoize(result, memo, pos, conditions)
    end
    conditions[0].times do |i|
      if arrangement[pos + i] == '.'
        return memoize(result, memo, pos, conditions)
      end
    end
    if arrangement[pos + conditions[0]] == '#'
      return memoize(result, memo, pos, conditions)
    end
    result +=
      count_arrangements(
        arrangement,
        pos + conditions[0] + 1,
        conditions[1..-1],
        min_length - conditions[0] - 1,
        memo
      )
    return memoize(result, memo, pos, conditions)
  end
end

def part2(input)
  input.sum do |arrangement, conditions|
    new_arr = 5.times.inject([]) { |acc| acc << arrangement }.join('?')
    new_cond = 5.times.inject([]) { |acc| acc << conditions }.flatten
    count_arrangements(
      new_arr,
      0,
      new_cond,
      (new_cond.sum + new_cond.length - 1),
      {}
    )
  end
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

puts part1(parsed)
puts part2(parsed)
