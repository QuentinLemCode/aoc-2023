require_relative './lib.rb'

input = get_input(15)
example = 'rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7'

def part1(input)
  input
    .map do |seq|
      seq
        .chars
        .inject(0) do |acc, cur|
          acc += cur.ord
          acc *= 17
          acc % 256
        end
    end
    .sum
end

def part2(input)
end

def parse(input)
  input.chomp.split(',')
end

parsed = parse(input)
puts part1(parsed)
puts part2(parsed)
