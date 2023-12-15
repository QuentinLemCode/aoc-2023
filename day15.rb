require_relative './lib.rb'

input = get_input(15)
example = 'rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7'

def part1(input)
  input.map { |seq| ahash(seq) }.sum
end

def ahash(str)
  str
    .chars
    .inject(0) do |acc, cur|
      acc += cur.ord
      acc *= 17
      acc % 256
    end
end

def part2(input)
  boxes = {}
  input.each do |seq|
    if seq.include?('=')
      label, focal = seq.split('=')
      idx = ahash(label)
      if labelpos = boxes[idx]&.find_index { |lens| lens.include?(label) }
        boxes[idx][labelpos] = "#{label}=#{focal}"
      else
        (boxes[idx] ||= []) << "#{label}=#{focal}"
      end
    elsif seq.include?('-')
      label, focal = seq.split('-')
      idx = ahash(label)
      if labelpos = boxes[idx]&.find_index { |lens| lens.include?(label) }
        boxes[idx].delete_at(labelpos)
      end
    end
  end

  boxes.sum do |idx, lens|
    lens.map.with_index do |len, lidx|
      (idx + 1) *  (lidx + 1) * len.split('=').last.to_i
    end
    .sum
  end
end

def parse(input)
  input.chomp.split(',')
end

parsed = parse(input)
puts part1(parsed)
puts part2(parsed)
