require_relative './lib.rb'

input = get_input(10)
example =
  '..F7.
.FJ|.
SJ.L7
|F--J
LJ...'

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
  return direction, newpos if char == '-' || char == '|' || char == 'S'
  newdir = newdirections[direction + char]
  raise 'invalid' if newdir.nil?
  [newdir, newpos]
end

puts part1(input)
