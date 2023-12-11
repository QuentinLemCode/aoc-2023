require_relative './lib.rb'

input = get_input(11)
example =
  '...#......
.......#..
#.........
..........
......#...
.#........
.........#
..........
.......#..
#...#.....'

def part1(input)
  map = input.split("\n").map { |row| row.split('') }
  expanded = expand(map)

  galaxies = []
  expanded.each_with_index do |row, i|
    row.each_with_index { |col, j| galaxies.push([i, j]) if col == '#' }
  end

  count = 0
  galaxies
    .combination(2)
    .each do |galaxy1, galaxy2|
      count += manhattan_distance(galaxy1, galaxy2)
    end
  count
end

def expand(arr)
  new_map = []
  arr.transpose.each do |col|
    if col.all? { |element| element == '.' }
      2.times { new_map.push(['.'] * arr.length) }
    else
      new_map.push(col)
    end
  end
  new_map = new_map.transpose
  idx =
    new_map.filter_map.with_index do |row, i|
      i if row.all? { |element| element == '.' }
    end
  idx.reverse.each { |i| new_map.insert(i, ['.'] * new_map[0].length) }

  new_map
end

def manhattan_distance(point1, point2)
  (point1[0] - point2[0]).abs + (point1[1] - point2[1]).abs
 end

puts part1(input)
