module PomodoroTracker
  class ActivityInventory
    include Enumerable

    attr_reader :activities

    def initialize(day = nil)
      @activities = Set.new
      @current_day = day || Day.today
    end

    def add(activity)
      @activities << activity
    end

    def <<(activity)
      @activities << activity
      self
    end

    def remove(activity)
      @activities.delete(activity)
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

