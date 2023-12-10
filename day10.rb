require_relative './lib.rb'

input = get_input(10)
example1 =
  '..F7.
.FJ|.
SJ.L7
|F--J
LJ...'

example2 =
"FF7FSF7F7F7F7F7F---7
L|LJ||||||||||||F--J
FL-7LJLJ||||||LJL-77
F--JF--7||LJLJ7F7FJ-
L---JF-JLJ.||-FJLJJ7
|F|F-JF---7F7-L7L|7|
|FFJF7L7F-JF7|JL---7
7-L-JL7||F7|L7F-7F7|
L.L7LFJ|||||FJL7||LJ
L7JLJL-JLJLJL--JLJ.L"

def part1(input)
  map = input.split("\n").map { |line| line.split('') }
  posX = map.find_index { |row| row.join.include?('S') }
  posY = map[posX].find_index('S')
  direction = 'D'
  found = false
  count = 0
  while !found
    direction, pos = traverse(map, [posX, posY], direction)
    posX, posY = pos
    found = true if map[posX][posY] == 'S'
    count += 1
  end
  count / 2
end

def traverse(map, pos, direction)
  newdirections = {
    'DL' => 'R',
    'DJ' => 'L',
    'RJ' => 'U',
    'R7' => 'D',
    'LL' => 'U',
    'LF' => 'D',
    'U7' => 'L',
    'UF' => 'R'
  }

  case direction
  when 'D'
    newpos = [pos[0] + 1, pos[1]]
  when 'U'
    newpos = [pos[0] - 1, pos[1]]
  when 'L'
    newpos = [pos[0], pos[1] - 1]
  when 'R'
    newpos = [pos[0], pos[1] + 1]
  end
  char = map[newpos[0]][newpos[1]]
  return direction, newpos if char == '-' || char == '|' || char == 'S' || char == 'l' || char == '='
  newdir = newdirections[direction + char]
  raise 'invalid' if newdir.nil?
  [newdir, newpos]
end

def part2(input)
  map = input.split("\n").map { |line| line.split('') }
  posX = map.find_index { |row| row.join.include?('S') }
  posY = map[posX].find_index('S')
  direction = 'D'
  found = false
  while !found
    newdirection, pos = traverse(map, [posX, posY], direction)
    posX, posY = pos
    found = true if map[posX][posY] == 'S'
    if newdirection == 'U' || direction == 'D'
      map[posX][posY] = 'l'
    else
      map[posX][posY] = '='
    end


    direction = newdirection
  end

  map.map do |row|
    count = 0
    inside = false

    row
      .join
      .gsub('=', '')
      .gsub('ll', '')
      .each_char do |char|
        if char == 'l'
          inside = !inside
        elsif inside
          count += 1
        end
      end
    count
  end.sum
end

puts part1(input)
puts part2(input)
