require 'date'

class GuardSleepTime
  include Comparable

  attr_accessor :time, :guard, :awakes

  def initialize(time:, guard: nil, awakes:)
    @time = time
    @guard = guard
    @awakes = awakes
  end

  def <=>(an_other)
    DateTime.parse(time) <=> DateTime.parse(an_other.time)
  end
end