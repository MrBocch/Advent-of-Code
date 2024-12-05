
def part1
  f = File.open("input.txt", "r").read
  data = f.split("\n\n")

  rules = data[0].split("\n")
  matrix = data[1].split("\n").map{|l| l.split(",")}.map{|l| l.map{|l| l.to_i } }

  # key   is n | _
  # value is _ | n
  comes_after= Hash.new([nil])
  rules.each do |pair|
    kv = pair.split("|").map{|n| n.to_i}

    if comes_after.include? kv[0]
      comes_after[kv[0]] << kv[1]
    else
      comes_after[kv[0]] = [kv[1]]
    end
  end

  sum = 0
  matrix.each do |list|
    sum += list[list.length/2] if valid_update(comes_after, list)
  end

  return sum
end

def valid_update(rules, list)
  passed = []
  list.each do |n|
    # puts "#{n} goes before #{rules[n]}"
    if passed.empty? then passed << n; next end

    if not (passed & rules[n]).any?
      passed << n
    else
      return false
    end
  end

  return true
end

def part2
  f = File.open("input.txt", "r").read
  data = f.split("\n\n")

  rules = data[0].split("\n")
  matrix = data[1].split("\n").map{|l| l.split(",")}.map{|l| l.map{|l| l.to_i } }

  comes_after= Hash.new([nil])
  rules.each do |pair|
    kv = pair.split("|").map{|n| n.to_i}
    if comes_after.include? kv[0]
      comes_after[kv[0]] << kv[1]
    else
      comes_after[kv[0]] = [kv[1]]
    end
  end

  # fix the incorrect line and sum up mid
  incorrect = []
  matrix.each do |line|
    incorrect << line if !valid_update(comes_after, line)
  end

  # i thought of this as soon as a pushed this file, just swap the values that are wrong?
  # because we know each list does not have repeat numbers, this shoould not be to hard
  sum = 0
  incorrect.each do |inc|
    while !valid_update(comes_after, inc)
      idx = get_index_of_wrong(comes_after, inc)
      temp = inc[idx-1]
      inc[idx-1] = inc[idx]
      inc[idx] = temp
    end
    # list is now correct
    sum += inc[inc.length/2]
  end

  return sum
end

def get_index_of_wrong(rules, list)
  passed = []
  list.each_with_index do |n, index|
    # puts "#{n} goes before #{rules[n]}"
    if passed.empty? then passed << n; next end

    if not (passed & rules[n]).any?
      passed << n
    else
      return index
    end
  end

  return true
end

puts "part1: #{part1}"
puts "part2: #{part2}"

'
this is O(n!)
so for n = 23, there will be, 25852016738884976640000
operations, yeah its not going to happen lol

incorrect.each do |l|

  l.permutation.each do |pe|
    if valid_update(comes_after, pe)
      sum += pe[pe.length/2]
      break
    end
  end
'
