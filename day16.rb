require_relative './lib.rb'
require 'set'
require 'matrix'

input = get_input(16)
example =
  ".|...\\....
|.-.\\.....
.....|-...
........|.
..........
.........\\
..../.\\\\..
.-.-/..|..
.|....-|.\\
..//.|...."

def part1(input, start = Vector[0, -1], initial = Vector[0, 1])
  beams = [{ pos: start, dir: initial }]
  positions = Set.new
  visited = Set.new
  count = 0
  last_len = 0
  loop do
    count += 1
    beams =
      beams.flat_map do |beam|
        positions.add(beam[:pos].to_a.join(','))
        new_pos = beam[:pos] + beam[:dir]
        if new_pos[0] < 0 || new_pos[1] < 0 || new_pos[0] >= input.length ||
             new_pos[1] >= input.length
          []
        elsif visited.include?([new_pos, beam[:dir]])
          []
        else
          visited.add([new_pos, beam[:dir]])
          char = input[new_pos[0]][new_pos[1]]
          if char == '\\'
            [{ pos: new_pos, dir: Vector[beam[:dir][1], beam[:dir][0]] }]
          elsif char == '/'
            [{ pos: new_pos, dir: Vector[-beam[:dir][1], -beam[:dir][0]] }]
          elsif char == '|' && beam[:dir][1] != 0
            [
              { pos: new_pos, dir: Vector[1, 0] },
              { pos: new_pos, dir: Vector[-1, 0] }
            ]
          elsif char == '-' && beam[:dir][0] != 0
            [
              { pos: new_pos, dir: Vector[0, 1] },
              { pos: new_pos, dir: Vector[0, -1] }
            ]
          else
            [{ pos: new_pos, dir: beam[:dir] }]
          end
        end
      end
    count = 0 if last_len != positions.length
    last_len = positions.length
    break if beams.empty? || count > 100
  end
  positions.length - 1
end

def printmap(input, positions)
  input.each_with_index do |row, i|
    row.each_with_index do |c, j|
      if positions.include?([i, j].join(','))
        print 'X'
      else
        print c
      end
    end
    puts
  end
end

def part2(input)
  result = (0...input.length).map do |i|
    [part1(input, Vector[i, -1], Vector[0, 1]), part1(input, Vector[-1, i], Vector[1, 0])]
  end + (0..input[0].length).map do |i|
    [part1(input, Vector[-1, i], Vector[1, 0]), part1(input, Vector[i, -1], Vector[0, 1])]
  end
  result.flatten.max
end

def parse(input)
  input.split("\n").map(&:chars)
end

parsed = parse(input)
puts part1(parsed)
puts part2(parsed)