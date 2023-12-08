require_relative './lib.rb'

input = get_input(8)
example =
  'LLR

  AAA = (BBB, BBB)
  BBB = (AAA, ZZZ)
  ZZZ = (ZZZ, ZZZ)'

def part1(input)
  lines = input.split("\n")
  instructions = lines.first.chars
  maps =
    lines[2..-1]
      .map { |line| line.split(' = ') }
      .inject({}) do |acc, (k, v)|
        acc[k.strip] = v.gsub(/\(|\)/, '').split(',').map(&:strip)
        acc
      end
  found = false
  position = 'AAA'
  steps = 0
  while !found
    instructions.each do |instruction|
      steps += 1
      if instruction == 'R'
        position = maps[position][1]
      elsif instruction == 'L'
        position = maps[position][0]
      end
      if position == 'ZZZ'
        found = true
        break
      end
    end
  end
  steps
end

puts part1(input)
