require_relative './lib.rb'

input = get_input(2)
example =
  'Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green'

def part1(input)
  load = { 'red' => 12, 'green' => 13, 'blue' => 14 }
  total = 0

  input
    .split("\n")
    .map do |game|
      gameid = game.split(':')[0].split(' ')[1].to_i
      game =
        game.split(':')[1]
          .split(';')
          .map do |round|
            round
              .split(',')
              .map do |draw|
                color = draw.strip.split(' ')[1]
                number = draw.split(' ')[0].to_i
                max = load[color]
                if number <= max
                  true
                else
                  false
                end
              end
          end
      total += gameid if game.flatten.all?
    end
  puts total
end

def part2(input)
  total = 0

  input
    .split("\n")
    .map do |game|
    load = { 'red' => 0, 'green' => 0, 'blue' => 0 }
      game.split(':')[1]
        .split(';')
        .map do |round|
          round
            .split(',')
            .each do |draw|
              color = draw.strip.split(' ')[1]
              number = draw.split(' ')[0].to_i
              min = load[color]
              load[color] = number if number > min
            end
        end
        total += load.values.inject(:*)
    end
  puts total
end

part1(input)
part2(input)
