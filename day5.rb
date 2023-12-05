require_relative './lib.rb'

input = get_input(5)
example = "seeds: 79 14 55 13

seed-to-soil map:
50 98 2
52 50 48

soil-to-fertilizer map:
0 15 37
37 52 2
39 0 15

fertilizer-to-water map:
49 53 8
0 11 42
42 0 7
57 7 4

water-to-light map:
88 18 7
18 25 70

light-to-temperature map:
45 77 23
81 45 19
68 64 13

temperature-to-humidity map:
0 69 1
1 0 69

humidity-to-location map:
60 56 37
56 93 4"


def part1(input)
  parts = input.split("\n\n")
  seeds = parts[0].split(":")[1].split(" ").map(&:to_i)
  maps = parts[1..-1].map do |map|
    map.split("\n")[1..-1].map { |row| row.split(" ").map(&:to_i) }
  end
  results = seeds.map do |seed|
    maps.each do |map|
      map.each do |range|
        if seed.between? range[1], range[1]+(range[2]-1)
          seed = ((seed - range[1]) + range[0])
          break
        end
      end
    end
    seed
  end
  results.min
end

puts part1(input)