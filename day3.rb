require_relative './lib.rb'

example =
  '467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..'

input = get_input(3)

def part1(input)
  numbers = []
  input
    .split("\n")
    .each_with_index do |line, index|
      line.scan(/\d+/) do |number|
        offset = $~.offset(0)
        if find_symbol(input.split("\n"), index, offset) == true
          numbers << number
        else
          puts "false: #{number}"
        end
      end
    end
  numbers.map(&:to_i).inject(:+)
end

def find_symbol(input, index, offset)
  not_symbol = %w[1 2 3 4 5 6 7 8 9 0 .]

  min = [offset[0] - 1, 0].max
  max = [offset[1] + 1, input[index].length - 1].min - 1

  if index > 0
    input[index - 1][min..max].each_char do |char|
      return true if char&.match?(/[^#{not_symbol.join}]/)
    end
  end
  input[index][min..max].each_char do |char|
    return true if char&.match?(/[^#{not_symbol.join}]/)
  end
  if index < input.length - 1
    input[index + 1][min..max].each_char do |char|
      return true if char&.match?(/[^#{not_symbol.join}]/)
    end
  end
end

def find_gear(input, index, offset)
  min = [offset[0] - 1, 0].max
  max = [offset[1] + 1, input[index].length - 1].min - 1

  if index > 0
    input[index - 1][min..max].each_char do |char|
      return true if char&.match?('*')
    end
  end
  input[index][min..max].each_char { |char| return true if char&.match?('*') }
  if index < input.length - 1
    input[index + 1][min..max].each_char do |char|
      return true if char&.match?('*')
    end
  end
end

def part2(input)
  gears = {}
  input = input.split("\n")
  input.each_with_index do |line, index|
    line.scan('*') do |number|
      offset = $~.offset(0)
      gears["#{index}-#{offset[0]}"] = []
    end
  end

  input.each_with_index do |line, index|
    line.scan(/\d+/) do |number|
      offset = $~.offset(0)
      min = [offset[0] - 1, 0].max
      max = [offset[1] + 1, input[index].length - 1].min - 1

      for j in -1..1
        next if index + j < 0 || index + j > input.length - 1
        idx = index + j

        input[idx][min..max].each_char.with_index do |char, i|
          if char&.include?('*') && gears["#{idx}-#{i+min}"].nil?
            puts 'a'
          end
          gears["#{idx}-#{i+min}"] << number if char&.include?('*')
        end
      end
    end
  end

  gears.filter { |k, v| v.length == 2 }.map { |k, v| v.map(&:to_i).inject(:*) }.inject(:+)
end

puts part1(input)
puts part2(input)
