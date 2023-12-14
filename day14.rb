require_relative './lib.rb'

input = get_input(14)
example =
  'O....#....
O.OO#....#
.....##...
OO.#O....O
.O.....O#.
O.#..O.#.#
..O..#O..O
.......O..
#....###..
#OO..#....'

def part1(input)
  result =
    input.transpose.map do |line|
      line.join
        .split('#', -1)
        .map do |group|
          rocks = group.count('O')
          ('O' * rocks) + ('.' * (group.length - rocks))
        end
        .join('#').chars
    end
    result.transpose.map.with_index do |line, index|
      line.join.count('O') * (result.length - index)
    end.sum
end

def part2(input)
end

def parse(input)
  input.split("\n").map(&:chars)
end

parsed = parse(input)
puts part1(parsed)
