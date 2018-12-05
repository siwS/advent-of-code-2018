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

    sleep_times.each_with_index do |sleep_time, index|
      if sleep_time.guard.nil?
        sleep_time.guard = sleep_times[index -1].guard
      end
    end

    sleep_times = sleep_times.select { |sleep_time| sleep_time.action != "begins shift" }

    minutes_slept = {}
    sleep_times.each_slice(2) do |minutes_asleep|
      guard = minutes_asleep[0].guard
      initial = minutes_asleep[0].time.minute.to_i
      final = minutes_asleep[1].time.minute.to_i-1

      (initial..final).each do |m|
        if minutes_slept[guard].nil?
          minutes_slept[guard] = {}
        end
        if minutes_slept[guard][m].nil?
          minutes_slept[guard][m] = 1
        else
          minutes_slept[guard][m] +=1
        end
      end
    end

    max_minute_per_guard = {}
    max_times_per_guard = {}

    minutes_slept.each do |guard, minutes_for_guard|
      max_times_for_guard = -1
      max_minute_for_guard = 0
      minutes_for_guard.each do |minute, times|
        if times > max_times_for_guard
          max_times_for_guard = times
          max_minute_for_guard = minute
        end
      end
      max_minute_per_guard[guard] = max_minute_for_guard
      max_times_per_guard[guard] = max_times_for_guard
    end

    guard_with_max_time = 0
    max_time_for_all_guards = -1
    max_times_per_guard.each do |guard, max_times|
      if max_time_for_all_guards < max_times
        max_time_for_all_guards = max_times
        guard_with_max_time = guard
      end
    end
    puts guard_with_max_time
    puts max_minute_per_guard[guard_with_max_time]
    puts max_minute_per_guard[guard_with_max_time] * guard_with_max_time
  end

  def extract_sleep_time(line)
    time = /\[.*?\]/.match(line)[0]
    guard_action = /(?<=\]).*$/.match(line)[0]
    guard_no = /(?<=Guard #)(\w+)/.match(guard_action)
    if guard_no != nil
      guard = guard_no[0].to_i
    end

    GuardSleepTime.new(time: time, guard: guard, action: find_action(line))
  end

  def find_action(line)
    action = "wakes up" if line.include?("wakes up")
    action = "begins shift" if line.include?("begins shift")
    action = "falls asleep" if line.include?("falls asleep")
    action
  end
end

c = GuardSleepProcessor.new
c.find_sleep_times