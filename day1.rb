require_relative './lib.rb'

input = get_input(1)

example =
  'two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen'

def part1(input)
  total = 0
  input.each_line do |line|
    numbers = line.split('').filter { |c| !!Integer(c, exception: false) }
    total += (numbers.first + numbers.last).to_i
  end

  puts total
end

def part2(input)
  total = 0

  spelled_numbers = {
    'one' => 1,
    'two' => 2,
    'three' => 3,
    'four' => 4,
    'five' => 5,
    'six' => 6,
    'seven' => 7,
    'eight' => 8,
    'nine' => 9
  }

  input.each_line do |line|
    indexedNumbers = {}
    line
      .split('')
      .each_with_index do |number, index|
        if (Integer(number, exception: false))
          indexedNumbers[index] = number.to_i
        end
      end
    # find spelled numbers index in line
    spelled_numbers.each do |key, value|
      line.scan(key) { |match| indexedNumbers[$~.offset(0)[0]] = value }
    end

    #sort indexed numbers by index
    indexedNumbers = indexedNumbers.sort_by { |k, v| k }.to_h

    #take last element from hash
    total += "#{indexedNumbers.values.first}#{indexedNumbers.values.last}".to_i
  end

  puts total
end

part1(input)
part2(input)
