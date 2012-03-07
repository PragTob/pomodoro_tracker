module PomodoroTracker
  class ActivityInventory
    include Enumerable

    attr_reader :activities

    def initialize
      @activities = []
    end

    def add(activity)
      @activities << activity
    end

    def <<(activity)
      @activities << activity
      self
    end

    def size
      @activities.size
    end

    def empty?
      @activities.empty?
    end

    def each(&blk)
      @activities.each(&blk)
    end

  end
end

