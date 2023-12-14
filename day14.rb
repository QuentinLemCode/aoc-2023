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
  calc_load(move_rocks(input.transpose).transpose)
end

# move west
def move_rocks(input)
  input.map do |line|
    line.join
      .split('#', -1)
      .map do |group|
        rocks = group.count('O')
        ('O' * rocks) + ('.' * (group.length - rocks))
      end
      .join('#').chars
  end
end

def calc_load(result)
  result.map.with_index do |line, index|
    line.join.count('O') * (result.length - index)
  end.sum
end

def cycle(platform)
  platform = move_rocks(platform.transpose).transpose # north
  platform = move_rocks(platform) # west
  platform = move_rocks(platform.reverse.transpose).transpose.reverse # south
  platform = move_rocks(platform.map(&:reverse)).map(&:reverse) # east
end

def part2(input)
  cycles = 1000000000

  platform = input
  memo = {}
  start,len = cycles.times do |i|
    cycle = memo[platform]
    if cycle
      break [i, i - cycle]
    end
    memo[platform] = i
    platform = cycle(platform)
  end

  data = platform

  last_cycle = start + (((cycles - start) / len) * len) + 1
  (last_cycle..cycles).each do
    platform = cycle(platform)
  end
  calc_load(platform)
end

def parse(input)
  input.split("\n").map(&:chars)
end

parsed = parse(input)
puts part1(parsed)
puts part2(parsed)

