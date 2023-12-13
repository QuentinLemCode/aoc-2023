require_relative './lib.rb'

input = get_input(13)
example = "#.##..##.
..#.##.#.
##......#
##......#
..#.##.#.
..##..##.
#.#.##.#.

#...##..#
#....#..#
..##..###
#####.##.
#####.##.
..##..###
#....#..#"

def part1(input)
  patterns = input.split("\n\n").map { |p| p.split("\n") }
  patterns.map { |p| (find_reflection(p)&.send(:*, 100)) || find_reflection(p.map(&:chars).transpose.map(&:join))}.sum
end

def find_reflection(pattern)
  pattern.each_cons(2).with_index do |(top, bottom), i|
    next if top != bottom
    next unless (0..i-1).all? do |j|
      break(true) if i+j+2 >= pattern.length || i-j-1 < 0
      pattern[i-j-1] == pattern[i+j+2]
    end
    return i+1 # 1 indexed
  end
  nil
end

def part2(input)

end

puts part1(input)