require "../../challenges/common/input_reader"
require "../../challenges/day4/guard_sleep_time"

class GuardSleepProcessor

  FABRIC_SIZE = 1000

  def find_sleep_times
    input = InputReader.read_lines_from_file
    sleep_times = []

    input.each do |line|
      sleep_times << extract_sleep_time(line)
    end

    sleep_times.sort!


  end

  def extract_sleep_time(line)
    time = /\[.*?\]/.match(line)[0]
    guard_action = /(?<=\]).*$/.match(line)[0]
    guard_no = /(?<=Guard\s)(\w+)/.match(guard_action)
    if guard_no != nil
      guard = guard_no[0]
    end

    awakes = line.include?("wakes up")
    GuardSleepTime.new(time: time, guard: guard, awakes: awakes)
  end

end

c = GuardSleepProcessor.new
c.find_sleep_times