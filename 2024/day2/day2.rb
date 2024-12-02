
def part1
  safe_reports = 0

  File.open("input.txt", "r").each do |line|
    report = line.split(" ").map{|n| n.to_i}

    if report[0] < report[1]
      if report == report.sort and gradual_diff(report)
        #puts "Safe: #{report}"
        safe_reports += 1
      end
    else # list is backwards
      if report == report.sort.reverse and gradual_diff(report)
        #puts "Safe: #{report}"
        safe_reports += 1
      end
    end
  end

  return safe_reports
end

def part2
  # so now, you must take a report that is unsafe
  # and delete one level, to make it safe,
  # i dont know how to smartly remove the correct level
  # so what if i just bruteforce all the incorrect levels?
  safe_reports = 0

  File.open("input.txt", "r").each do |line|
    report = line.split(" ").map{|n| n.to_i}

    if report_is_safe? report
      safe_reports += 1
    else
      # mutate list to every possilbe combo
      report.each_index do |i|
        copy_report = report.clone
        copy_report.delete_at(i)
        if report_is_safe? copy_report
          safe_reports += 1
          break
        end
      end
    end

  end

  return safe_reports
end

def report_is_safe?(report)
  if report[0] < report[1]
    if report == report.sort and gradual_diff(report)
      return true
    end
  else # list is backwards
    if report == report.sort.reverse and gradual_diff(report)
      return true
    end
  end

  return false
end

def gradual_diff(report)
  0.upto(report.length() - 2) do |i|
    dif = (report[i] - report[i+1]).abs
    if not (dif > 0 and dif <= 3)
      return false
    end
  end

  return true
end

puts "Part1: #{part1}"
puts "Part2: #{part2}"
