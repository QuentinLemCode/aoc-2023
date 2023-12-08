require_relative './lib.rb'

input = get_input(8)
example =
  'LR

11A = (11B, XXX)
11B = (XXX, 11Z)
11Z = (11B, XXX)
22A = (22B, XXX)
22B = (22C, 22C)
22C = (22Z, 22Z)
22Z = (22B, 22B)
XXX = (XXX, XXX)'

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
      direction = instruction == 'R' ? 1 : 0
      position = maps[position][direction]
      if position == 'ZZZ'
        found = true
        break
      end
    end
  end
  steps
end

def part2(input)
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
  positions = maps.find_all { |k, v| k.end_with?('A') }.map(&:first)

  lens =
    positions.map do |start_p|
      instructions.cycle.each_with_index do |instruction, i|
        direction = instruction == 'R' ? 1 : 0
        start_p = maps[start_p][direction]
        break i + 1 if start_p.end_with?('Z')
      end
    end

    lens.reduce(&:lcm)
end

puts part1(input)
puts part2(input)