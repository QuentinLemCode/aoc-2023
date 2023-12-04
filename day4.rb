require_relative './lib.rb'

input = get_input(4)
example = "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11"

def part1(input)
  input
    .split("\n")
    .map do |card|
      wins = card.split(':')[1].split('|')[0].split(' ').map(&:to_i)
      have = card.split(':')[1].split('|')[1].split(' ').map(&:to_i)
      wons = wins & have
      count = wons.length
      (2 ** (count - 1)).floor
    end
    .inject(:+)
end

puts part1(input)