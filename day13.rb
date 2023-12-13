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

def find_reflection_smudge(pattern)
  for i in 0..pattern.length-2
    smudges = 0
    next unless (0..i).all? do |j|
      break(true) if i+j+1 >= pattern.length || i-j < 0
      a = pattern[i-j]
      b = pattern[i+j+1]
      next(true) if a == b
      smudges += a.chars.zip(b.chars).filter { |x, y| x != y }.length
      next(false) if smudges > 1
      true
    end
    next if smudges != 1
    return i+1 # 1 indexed
  end
  nil
end

def part2(input)
  patterns = input.split("\n\n").map { |p| p.split("\n") }
  patterns.map { |p| (find_reflection_smudge(p)&.send(:*, 100)) || find_reflection_smudge(p.map(&:chars).transpose.map(&:join))}.sum
end

puts part1(input)
puts part2(input)