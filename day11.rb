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

def expand(arr, x = 2)
  new_map = []
  arr.transpose.each do |col|
    if col.all? { |element| element == '.' }
      x.times { new_map.push(['.'] * arr.length) }
    else
      new_map.push(col)
    end
  end
  new_map = new_map.transpose
  idx =
    new_map.filter_map.with_index do |row, i|
      i if row.all? { |element| element == '.' }
    end
  idx.reverse.each { |i| (x-1).times {new_map.insert(i, ['.'] * new_map[0].length)} }

  new_map
end

def manhattan_distance(point1, point2)
  (point1[0] - point2[0]).abs + (point1[1] - point2[1]).abs
 end

def part2(input)
  map = input.split("\n").map { |row| row.split('') }
  galaxies = []
  factor = 1000000
  map.each_with_index do |row, i|
    row.each_with_index { |col, j| galaxies.push([i, j]) if col == '#' }
  end

  rowidx = map.filter_map.with_index do |row, i|
    i if row.all? { |element| element == '.' }
  end

  colidx = map.transpose.filter_map.with_index do |col, i|
    i if col.all? { |element| element == '.' }
  end

  galaxies.map! do |galaxy|
    row, col = galaxy
    newrow = row
    newcol = col
    rowidx.each do |i|
      if row > i
        newrow += (factor-1)
      end
    end
    colidx.each do |i|
      if col > i
        newcol += (factor-1)
      end
    end
    [newrow, newcol]
  end

  count = 0
  galaxies
    .combination(2)
    .each do |galaxy1, galaxy2|
      count += manhattan_distance(galaxy1, galaxy2)
    end
  count

end


puts part1(input)
puts part2(input)
