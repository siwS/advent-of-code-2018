require 'date'

class GuardSleepTime
  include Comparable

  attr_accessor :time, :guard, :action

  def initialize(time:, guard: nil, action:)
    @time = DateTime.parse(time)
    @guard = guard
    @action = action
  end

  def <=>(an_other)
    time <=> an_other.time
  end
end