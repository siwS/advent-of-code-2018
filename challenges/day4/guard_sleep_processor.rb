require "../../challenges/common/input_reader"
require "../../challenges/day4/guard_sleep_time"

class GuardSleepProcessor

  FABRIC_SIZE = 1000

  def find_sleep_times
    input = InputReader.read_lines_from_file
    sleep_times = []
    guards_total_sleep = {}

    max_minutes_sleeping = 0
    guard_max_minutes_sleeping = 0

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

    sleep_times.each_with_index do |sleep_time, index|
      if guards_total_sleep[sleep_time.guard].nil?
        guards_total_sleep[sleep_time.guard] = 0
      end

      if sleep_time.action == "wakes up"
        total_slept = sleep_time.time.minute - sleep_times[index-1].time.minute
        guards_total_sleep[sleep_time.guard] += total_slept
      end

      if max_minutes_sleeping < guards_total_sleep[sleep_time.guard]
        max_minutes_sleeping = guards_total_sleep[sleep_time.guard]
        guard_max_minutes_sleeping = sleep_time.guard
      end
    end

    sleep_times = sleep_times.select { |sleep_time| sleep_time.guard == guard_max_minutes_sleeping }

    minute_mostly_slept = 0

    minutes_slept = {}
    sleep_times.each_slice(2) do |minutes_asleep|
      initial = minutes_asleep[0].time.minute.to_i
      final = minutes_asleep[1].time.minute.to_i-1

      (initial..final).each do |m|
        if minutes_slept[m].nil?
          minutes_slept[m] = 0
        else
          minutes_slept[m] +=1
        end

        if minutes_slept[minute_mostly_slept].nil? || minutes_slept[minute_mostly_slept] < minutes_slept[m]
          minute_mostly_slept = m
        end
      end
    end
    puts minute_mostly_slept
    puts guard_max_minutes_sleeping
    puts guard_max_minutes_sleeping * minute_mostly_slept
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