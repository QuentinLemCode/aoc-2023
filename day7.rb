require_relative './lib.rb'

input = get_input(7)
example =
  '32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483'

def part1(input)
  hands = input.split("\n").map { |line| line.split(' ') }.inject(Hash.new(0)) do |hands, line|
    hands[line[0]] = line[1]
    hands
  end
  hands.sort do |hand1, hand2|
    rank1, rank2 = hand_rank(hand1[0]), hand_rank(hand2[0])
    if rank1 == rank2
      cards1 = hand1[0].chars.map { |card| CARD_VALUES[card] }
      cards2 = hand2[0].chars.map { |card| CARD_VALUES[card] }
      sortval = 0
      cards1.zip(cards2).each do |card1, card2|
        next if card1 == card2
        sortval = card1 < card2 ? 1 : -1
        break
      end
      sortval || 0
    else
      rank2 <=> rank1
    end
  end.reverse.map.with_index do |hand, i|
    (i+1) * hand[1].to_i
  end.sum
end

CARD_VALUES = {
  'A' => 14, 'K' => 13, 'Q' => 12, 'J' => 11, 'T' => 10,
  '9' => 9, '8' => 8, '7' => 7, '6' => 6, '5' => 5,
  '4' => 4, '3' => 3, '2' => 2
}

def hand_rank(hand)
  counts = Hash.new(0)
  hand.chars.each { |card| counts[card] += 1 }

  case counts.values.sort
  when [1, 4]
    6
  when [2, 3]
    5
  when [1, 1, 3]
    4
  when [1, 2, 2]
    3
  when [1, 1, 1, 2]
    2
  when [1, 1, 1, 1, 1]
    1
  else
    7
  end
end

puts part1(input)
