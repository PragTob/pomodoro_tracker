module PomodoroTracker
  class ActivityInventory

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
  end
end

