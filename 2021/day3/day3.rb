
def part_1(file)
    bits = []
    bits = File.read(file)
    bits = bits.split("\n")
    most_com = []
    (0...bits[0].length).each do |i|
        w1 = bits.filter{|row| row[i] == "1"}.length
        w0 = bits.filter{|row| row[i] == "0"}.length
        most_com.push(w1 - w0)
    end
    gamma = most_com.map{|n| normalize(n)}.join("").to_i(2)
    epsilon = most_com.map{|n| normalize(n)}.map{|n| if n == 1 then 0 else 1 end}.join("").to_i(2)

    return gamma * epsilon

end


def part_2(file)

    bits = File.read(file)
    bits = bits.split("\n")

    oxygen_bits = []
    co2_bits = []
    (0...bits[0].length).each do |i|
        most_comm = find_nth_comm(bits, i)
        if i == 0
            most_comm = find_nth_comm(bits, i)
            most_uncomm = find_nth_uncomm(bits, i)

            oxygen_bits = bits.filter{|row| row[i] == most_comm.to_s}
            co2_bits = bits.filter{|row| row[i] == most_uncomm.to_s}
            next
        end

        most_comm = find_nth_comm(oxygen_bits, i)
        if oxygen_bits.length > 1
            case most_comm
            when 0, 1
                oxygen_bits.filter!{|row| row[i] == most_comm.to_s}
            else
                # when oxygen, you keep the one with 1
                oxygen_bits.filter!{|row| row[i] == "1"}
            end
        end

        most_uncomm = find_nth_uncomm(co2_bits, i)
        if co2_bits.length > 1
            case most_uncomm
            when 0, 1
                co2_bits.filter!{|row| row[i] == most_uncomm.to_s}
            else
                # when co2, keep the one with 0
                co2_bits.filter!{|row| row[i] == "0"}
            end
        end

    end
    oxygen_rate = oxygen_bits[0].to_i(2)
    co2_rate = co2_bits[0].to_i(2)

    return oxygen_rate * co2_rate
end

def normalize(n)
    return 1 if n > 0
    return 0
end

def find_nth_comm(bits, n)
    w1 = bits.filter{|row| row[n] == "1"}.length
    w0 = bits.filter{|row| row[n] == "0"}.length
    diff = w1 - w0
    return 1 if diff > 0
    return 0 if diff < 0
    # meaning what if both the same?
    return -1
end

def find_nth_uncomm(bits, n)
    w1 = bits.filter{|row| row[n] == "1"}.length
    w0 = bits.filter{|row| row[n] == "0"}.length
    diff = w1 - w0
    return 0 if diff > 0
    return 1 if diff < 0
    # meaning what if both the same?
    return -1
end

puts "Part 1: #{part_1("input.txt")}"
puts "Part 2: #{part_2("input.txt")}"
