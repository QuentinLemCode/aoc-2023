require_relative './lib.rb'

input = get_input(9)
example = "0 3 6 9 12 15
1 3 6 10 15 21
10 13 16 21 30 45"


def part1(input)
  datasets = input.split("\n").map{ |x| x.split(' ').map(&:to_i)}
  datasets.map do |dataset|
    sequences = [dataset]
    while !sequences.last.all? { |x| x === 0}
      sequences << sequences.last.each_cons(2).map { |a, b| b - a }
    end
    sequences.map(&:last).sum
  end.sum
end


puts part1(input)